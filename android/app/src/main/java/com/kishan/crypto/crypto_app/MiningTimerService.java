package com.kishan.crypto.crypto_app;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.Service;
import android.content.Context;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.IBinder;
import com.kishan.crypto.crypto_app.R;

public class MiningTimerService extends Service {

    private static final String CHANNEL_ID = "mining_service_channel";

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        // Create Notification Channel (for Android O and above)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationChannel channel = new NotificationChannel(
                    CHANNEL_ID,
                    "Mining Service",
                    NotificationManager.IMPORTANCE_DEFAULT
            );
            NotificationManager manager = getSystemService(NotificationManager.class);
            if (manager != null) {
                manager.createNotificationChannel(channel);
            }
        }

        // Create a notification
        Notification notification = null;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            notification = new Notification.Builder(this, CHANNEL_ID)
                    .setContentTitle("Mining in Progress")
                    .setContentText("Your mining service is running.")
                    .setSmallIcon(R.drawable.ic_timer)  // Set an appropriate icon for your app
                    .build();
        }

        // Start the service in the foreground with the created notification
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.ECLAIR) {
            startForeground(1, notification);
        }

        // Return START_STICKY so the service is restarted if killed
        return START_STICKY;
    }

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        // Make sure to call stopForeground to remove the notification when service is destroyed
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.ECLAIR) {
            stopForeground(true);
        }
    }
}
