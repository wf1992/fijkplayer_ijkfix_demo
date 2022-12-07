package com.example.fijkplayer_example;

import android.Manifest;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.view.KeyEvent;

import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import java.util.ArrayList;

import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity implements com.example.fijkplayer_ijkfix.FijkVolume.CanListenVolumeKey {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        ArrayList<String> noGranted = new ArrayList<>();
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.INTERNET)
                != PackageManager.PERMISSION_GRANTED) {
            noGranted.add(Manifest.permission.INTERNET);
        }
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.WRITE_EXTERNAL_STORAGE)
                != PackageManager.PERMISSION_GRANTED) {
            noGranted.add(Manifest.permission.WRITE_EXTERNAL_STORAGE);
        }
        if (noGranted.size() > 0) {
            ActivityCompat.requestPermissions(this, noGranted.toArray(new String[0]), 1);
        }
    }

    private com.example.fijkplayer_ijkfix.FijkVolume.VolumeKeyListener volumeKeyListener;

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        switch (keyCode) {
            case KeyEvent.KEYCODE_VOLUME_DOWN:
            case KeyEvent.KEYCODE_VOLUME_UP:
            case KeyEvent.KEYCODE_VOLUME_MUTE:
                if (volumeKeyListener != null) {
                    return volumeKeyListener.onVolumeKeyDown(keyCode, event);
                }
            default:
                break;
        }
        return super.onKeyDown(keyCode, event);
    }


    @Override
    public void setVolumeKeyListener(com.example.fijkplayer_ijkfix.FijkVolume.VolumeKeyListener listener) {
        volumeKeyListener = listener;
    }
}
