package com.kishan.crypto.crypto_app;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.kishan.crypto.crypto_app/mining";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // Initialize MethodChannel to communicate between Flutter and native code
        new MethodChannel(getFlutterEngine().getDartExecutor(), CHANNEL).setMethodCallHandler(
                (call, result) -> {
                    if (call.method.equals("startMining")) {
                        startMiningService();
                        result.success("Mining service started");
                    } else if (call.method.equals("stopMining")) {
                        stopMiningService();
                        result.success("Mining service stopped");
                    } else {
                        result.notImplemented();
                    }
                }
        );
    }

    private void startMiningService() {
        try {
            // Start the service for mining
            Intent serviceIntent = new Intent(MainActivity.this, MiningTimerService.class);
            startService(serviceIntent);
            Log.d("MiningService", "Mining service started");
        } catch (Exception e) {
            Log.e("MiningService", "Error starting mining service", e);
        }
    }

    private void stopMiningService() {
        try {
            // Stop the mining service
            Intent serviceIntent = new Intent(MainActivity.this, MiningTimerService.class);
            stopService(serviceIntent);
            Log.d("MiningService", "Mining service stopped");
        } catch (Exception e) {
            Log.e("MiningService", "Error stopping mining service", e);
        }
    }
}
