import 'dart:async';
import 'dart:convert';
import 'package:crypto_app/network_services/models/start_mining_model.dart';
import 'package:crypto_app/network_services/models/transacton_list_model.dart';
import 'package:crypto_app/utills/dprint.dart';
import 'package:http/http.dart' as http;
import 'package:crypto_app/utills/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reown_appkit/reown_appkit.dart';
import '../../network_services/api_helper.dart';
import '../../network_services/models/home_model.dart';
import '../../utills/constants.dart';
import '../../utills/storage.dart';
import '../../utills/widget_utils.dart';

class WalletInfoController extends GetxController with GetTickerProviderStateMixin{
  late TabController tabController;
  RxBool isConnected = false.obs;
  RxString walletAddress = ''.obs;
  RxInt  usdtWalletBalance = 0.obs;
  RxString successAddress = "".obs;
  RxString usdtInOrder = "0.00".obs;

  String type = "";

  final ApiHelper _apiHelper = ApiHelper.to;
  HomeData? homeData;
  List<TransactionData>? transactionListData;
  RxBool loading = false.obs;

  final amountController = TextEditingController();

  final appKitModal = ReownAppKitModal(
    context: Get.context!,
    projectId: 'b8fae25c9c14c3931cab9f7e669a749f',
    metadata: const PairingMetadata(
      name: 'X-Chain',
      description: 'Example app description',
      url: 'https://teamxchain.com/',
      icons: ['https://pbs.twimg.com/media/F4zhLiSWAAEMf07.jpg'],
      redirect: Redirect(  // OPTIONAL
        native: 'xchain://',
        universal: 'https://reown.com/xchain',
        linkMode: true
      ),
    ),
  );

  String usdtAbi = '''
[
  {
    "constant": false,
    "inputs": [
      { "name": "_to", "type": "address" },
      { "name": "_value", "type": "uint256" }
    ],
    "name": "transfer",
    "outputs": [{ "name": "", "type": "bool" }],
    "type": "function"
  }
]
''';

  final usdtContract = DeployedContract(
    ContractAbi.fromJson(
      jsonEncode([
        {
          "constant": true,
          "inputs": [],
          "name": "decimals",
          "outputs": [{"name": "", "type": "uint8"}],
          "type": "function"
        },
        {
          "constant": false,
          "inputs": [
            {"name": "_to", "type": "address"},
            {"name": "_value", "type": "uint256"}
          ],
          "name": "transfer",
          "outputs": [{"name": "", "type": "bool"}],
          "type": "function"
        }
      ]),
      'Tether USD',
    ),
    EthereumAddress.fromHex('0xdAC17F958D2ee523a2206206994597C13D831ec7'), // USDT contract address
  );

  @override
  Future<void> onInit() async {
    type = Get.arguments;
    tabController = TabController(length: 2, vsync: this);
    Future.microtask(() {
      homeDashboard();
      transactionHistory();
    });

    // AppKit Modal instance

// Register here the event callbacks on the service you'd like to use. See `Events` section.
    await appKitModal.init();

    super.onInit();
  }

  Future<void> homeDashboard() async {
    loading.value = true;
    var payload = {
      "user_id" : Storage.getValue(Constants.userId).toString()
    };

    _apiHelper.homeDashboard(jsonEncode(payload)).futureValue((v) {
      var res = HomeModel.fromJson(jsonDecode(v));
      if(res.status ??  false) {
        homeData = res.data ?? HomeData();

        // clear storage data
        if(Storage.hasData(Constants.xbtBalance)){
          Storage.removeValue(Constants.xbtBalance);
        }
        if(Storage.hasData(Constants.xbtCoinBalance)){
          Storage.removeValue(Constants.xbtCoinBalance);
        }
        if(Storage.hasData(Constants.usdtBalance)){
          Storage.removeValue(Constants.usdtBalance);
        }

        //save storage data in local
        Storage.saveValue(Constants.xbtBalance, res.data!.xbtBalance.toString());
        Storage.saveValue(Constants.xbtCoinBalance, res.data!.xcoinBalance.toString());
        Storage.saveValue(Constants.usdtBalance, res.data!.usdtBalance.toString());
      } else  {
        WidgetUtils.showSnackbar(res.message ?? "something went wrong");
      }
      loading.value = false;
    }, retryFunction: homeDashboard);
  }

  Future<void> transactionHistory() async  {
    loading.value = true;

    var payload = {
      "user_id" : "${Storage.getValue(Constants.userId)}"
    };
    transactionListData?.clear();
    _apiHelper.transactionHistory(jsonEncode(payload)).futureValue((v) {
      var res = TransactionListModel.fromJson(jsonDecode(v));
      if(res.status ?? false) {
        transactionListData = res.data?.where((transaction) {
          return transaction.currency?.toLowerCase() == type.toLowerCase();  // Compare currency with type
        }).toList() ?? [];
        update();
      } else {
       // WidgetUtils.showSnackbar(res.message ?? "something went wrong");
      }
      loading.value = false;
    }, retryFunction: transactionHistory);
  }

  // Set up event listeners for AppKit Modal
  void setupAppKitListeners() {
    appKitModal.onModalConnect.subscribe((ModalConnect? event) {
      // Handle modal connection
      dprint('Modal Connected: ');
    });

    appKitModal.onModalUpdate.subscribe((ModalConnect? event) {
      // Handle modal update
      dprint('Modal Updated:');
    });

    appKitModal.onModalNetworkChange.subscribe((ModalNetworkChange? event) {
      // Handle network change
      dprint('Network Changed: ${event?.chainId}');
    });

    appKitModal.onModalDisconnect.subscribe((ModalDisconnect? event) {
      // Handle modal disconnection
      dprint('Modal Disconnected');
    });

    appKitModal.onModalError.subscribe((ModalError? event) {
      // Handle modal error
      dprint('Error Occurred: ');
    });

    // Session specific events
    appKitModal.onSessionExpireEvent.subscribe((SessionExpire? event) {
      // Handle session expiration
      dprint('Session Expired');
    });

    appKitModal.onSessionUpdateEvent.subscribe((SessionUpdate? event) {
      // Handle session update
      dprint('Session Updated:');
    });

    appKitModal.onSessionEventEvent.subscribe((SessionEvent? event) {
      // Handle session event
      dprint('Session Event:');
    });
  }

  // add money
  Future<void> addMoneyFromWallet() async {
    dprint("amount===> ${amountController.text}");
    try {
      // Step 1: Validate the amount
      final inputAmount = double.tryParse(amountController.text);
      if (inputAmount == null || inputAmount <= 0) {
        WidgetUtils.showAlertDialogue(Get.context!, "Invalid amount entered.");
        return;
      }

      // Step 2: Define target wallet and USDT contract address
      const targetWalletAddress = "0x3547A4A0Db0dA764Bf37B9D120b4223ce9ecf117";
      const usdtContractAddress = "0x55d398326f99059fF775485246999027B3197955"; // USDT on BEP-20

      // Step 3: Get user's wallet address
      final walletAddress = appKitModal.session!.namespaces?["eip155"]?.accounts.first.split(':').last;

      // Step 4: Convert amount to smallest denomination (USDT has 6 decimals)
      final usdtValue = (inputAmount * 1000000).toInt();

      dprint("amount in smallest unit ===> $usdtValue");

      // Step 5: Request the transfer
      final result = await appKitModal.requestWriteContract(
        topic: appKitModal.session!.topic,
        chainId: "eip155:1", // Binance Smart Chain (Mainnet)
        deployedContract: DeployedContract(
            ContractAbi.fromJson(usdtAbi, "USDT"),
          EthereumAddress.fromHex(usdtContractAddress),
         // address: EthereumAddress.fromHex(usdtContractAddress),
         // abi: ContractAbi.fromJson(usdtAbi, "USDT"),
        ),
        functionName: 'transfer',
        transaction: Transaction(
          from: EthereumAddress.fromHex(walletAddress!),
        ),
        parameters: [
          EthereumAddress.fromHex(targetWalletAddress), // Target address
          BigInt.from(usdtValue), // Amount in smallest unit
        ],
      );

      dprint("Transfer successful: $result");

      // Step 6: Monitor and update the balance
      monitorTransaction(result.toString());
      monitorBalance();
    } catch (e) {
      if (e.toString().contains("User denied transaction signature")) {
        dprint("Transaction rejected by user.");
        WidgetUtils.showAlertDialogue(Get.context!, "You rejected the transaction request.");
      } else {
        dprint("An unexpected error occurred: $e");
        WidgetUtils.showAlertDialogue(Get.context!, "An unexpected error occurred: $e");
      }
    }
  }

  Future<void> transferUSDT() async {
    const usdtContractAddress = "0x55d398326f99059fF775485246999027B3197955"; // USDT Contract on BEP20
    const receiverAddress = "0x3547A4A0Db0dA764Bf37B9D120b4223ce9ecf117";  // Receiver's wallet address

    try {
      // Step 1: Validate session and namespaces
      if (appKitModal.session == null) {
        dprint("Session not initialized.");
        WidgetUtils.showAlertDialogue(Get.context!, "Please connect your wallet.");
        return;
      }

      final namespaces = appKitModal.session!.namespaces;
      dprint("Namespaces: $namespaces");

      if (namespaces == null || namespaces["eip155"] == null) {
        dprint("eip155 namespace not found.");
        WidgetUtils.showAlertDialogue(Get.context!, "Please connect to Binance Smart Chain (BEP20).");
        return;
      }

      // Step 2: Get the wallet address
      final accounts = namespaces["eip155"]?.accounts;
      if (accounts == null || accounts.isEmpty) {
        dprint("No accounts found in namespaces.");
        WidgetUtils.showAlertDialogue(Get.context!, "No accounts found. Please reconnect your wallet.");
        return;
      }

      final walletAddress = accounts.first.split(':').last;
      dprint("Wallet Address: $walletAddress");

      // Step 3: Validate chain ID
      final chainId = appKitModal.selectedChain?.chainId;
      dprint("Selected Chain ID: $chainId");
      if (chainId != "eip155:56") {
        dprint("Unsupported chain ID. Requesting switch to Binance Smart Chain...");
      /*  await appKitModal.requestSwitchToChain(
          ReownAppKitModalNetworkInfo(
              name: "Binance Smart Chain", // Network name
              chainId: "eip155:56",        // Chain ID for Binance Smart Chain
              currency: "BNB",            // Native currency for Binance Smart Chain
              rpcUrl: "https://bsc-dataseed.binance.org/", // RPC URL for BSC
              explorerUrl: "https://bscscan.com"          // Explorer URL for BSC
          ),
        );*/
        final newChainId = appKitModal.selectedChain?.chainId;
        dprint("New Chain ID after switch: $newChainId");
        if (newChainId != "56") {
          WidgetUtils.showAlertDialogue(
            Get.context!,
            "Failed to switch to Binance Smart Chain. Please switch manually in your wallet.",
          );
          return;
        }
      }

      // Step 4: Validate and calculate USDT amount
      final amountToSend = double.tryParse(amountController.text);
      if (amountToSend == null || amountToSend <= 0) {
        dprint("Invalid amount: ${amountController.text}");
        WidgetUtils.showAlertDialogue(Get.context!, "Enter a valid USDT amount.");
        return;
      }

      final usdtValue = (amountToSend * 10e17).toInt(); // Convert to micro USDT
      dprint("USDT Value (smallest unit): $usdtValue");
      usdtInOrder.value = amountController.text;
      // Step 5: Perform transfer
      final result = await appKitModal.requestWriteContract(
        topic: appKitModal.session!.topic,
        chainId: "eip155:56",
        deployedContract: DeployedContract(
            ContractAbi.fromJson(usdtAbi, "USDT"),
            EthereumAddress.fromHex(usdtContractAddress),
        ),
        functionName: 'transfer',
        transaction: Transaction(
          from: EthereumAddress.fromHex(walletAddress),
        ),
        parameters: [
          EthereumAddress.fromHex(receiverAddress),
          BigInt.from(usdtValue),
        ],
      );
      successAddress.value = result.toString();
      dprint("USDT Transfer Successful: $result");
      //transaction is successful

      Storage.saveValue(Constants.usdtInOrder, amountController.text);
      await monitorTransaction(result.toString());
      usdtAdd();
    } catch (e) {
      if (e.toString().contains("User denied transaction signature")) {
        dprint("Transaction rejected by user.");
        usdtReject();
       // WidgetUtils.showAlertDialogue(Get.context!, "You rejected the transaction request.");
      } else {
        dprint("An unexpected error occurred: $e");
      }
    }
  }

  Future<double> getCryptoToUSDTExchangeRate() async {
    // Mock API call
    final response = await http.get(
      Uri.parse('https://min-api.cryptocompare.com/data/price?fsym=USDT&tsyms=USD'),
    );
    final data = jsonDecode(response.body);
    dprint('usd rate===>${data["USD"]}');
    return data['USD']; // Adjust based on the selected crypto
  }

  void updateAppWallet(int usdtValue) {
    // Add USDT value to app wallet
      usdtWalletBalance += usdtValue; // appWalletBalance is your local state or fetched from the server
      update();
    dprint("Wallet updated with $usdtWalletBalance USDT");
  }

  String formatWalletAddress(String address, {int start = 6, int end = 4}) {
    if (address.length <= start + end) return address;
    return '${address.substring(0, start)}...${address.substring(address.length - end)}';
  }

  void logApprovedEvents() {
    final events = appKitModal.getApprovedEvents();
    dprint("Approved events: $events");
  }

  Future<dynamic> checkTransactionStatus(String txHash) async {
    final status = await appKitModal.requestReadContract(
      topic: appKitModal.session!.topic,
      chainId: appKitModal.selectedChain!.chainId,
      deployedContract: usdtContract, // Your DeployedContract object
      functionName: 'getTransactionStatus', // Replace with the actual function name
      parameters: [txHash],
    );
    dprint("Transaction status: $status");
    return status;
  }

  Future<void> monitorTransaction(String txHash) async {
    Timer.periodic(const Duration(seconds: 120), (timer) async {
      final status = await checkTransactionStatus(txHash);
      dprint("time==>${timer.tick}");
      dprint("transaction status==>$status");
      if (status == "Success") {
        timer.cancel();
        dprint("Transaction confirmed!");
        monitorBalance();
      } else {
        dprint("transaction rejected");
      }
    });
  }

  void openBlockExplorer() {
    appKitModal.launchBlockExplorer();
  }

  void monitorBalance() {
    appKitModal.balanceNotifier.addListener(() {
      final updatedBalance = appKitModal.balanceNotifier.value;
      dprint("Balance updated: $updatedBalance");
    });
  }

  Future<void> usdtAdd() async {
    loading.value = true;
    var payload = {
      "user_id" : Storage.getValue(Constants.userId).toString(),
      "amount" : amountController.text,
      "ref_address" : successAddress.value,
    };

    _apiHelper.usdtSuccess(jsonEncode(payload)).futureValue((v) {
      var res = StartMiningModel.fromJson(jsonDecode(v));
      if(res.status ??  false) {
        usdtInOrder.value = "0.00";
        Storage.removeValue(Constants.usdtInOrder);
        WidgetUtils.showAlertDialogue(Get.context!,res.message ?? "Transaction Successful");
      } else  {
        WidgetUtils.showSnackbar(res.message ?? "something went wrong");
      }
      loading.value = false;
    }, retryFunction: usdtAdd);
  }

  Future<void> usdtReject() async {
    loading.value = true;
    var payload = {
      "user_id" : Storage.getValue(Constants.userId).toString(),
      "amount" : amountController.text,
      "status" : "Reject",
    };

    _apiHelper.usdtReject(jsonEncode(payload)).futureValue((v) {
      var res = StartMiningModel.fromJson(jsonDecode(v));
      if(res.status ??  false) {
        usdtInOrder.value = "0.00";
        Storage.removeValue(Constants.usdtInOrder);
        WidgetUtils.showAlertDialogue(Get.context!,"Transaction Rejected");
      } else  {
        WidgetUtils.showSnackbar(res.message ?? "something went wrong");
      }
      loading.value = false;
    }, retryFunction: usdtReject);
  }

  /* var connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
          name: '31ProjX',
          description: 'An app for converting pictures to NFT',
          url: 'https://walletconnect.org',
          icons: [
            'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
          ]));

  loginUsingMetamask(BuildContext context) async {
    if (!connector.connected) {
      try {
        var session = await connector.createSession(onDisplayUri: (uri) async {
          _uri = uri;
          await launchUrlString(uri, mode: LaunchMode.externalApplication);
        });
        _session = session;
        update();
      } catch (exp) {
        dprint(exp);
      }
    }
  }*/

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}