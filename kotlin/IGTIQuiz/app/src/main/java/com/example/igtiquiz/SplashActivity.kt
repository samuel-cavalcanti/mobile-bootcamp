package com.example.igtiquiz

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.widget.ImageView
import androidx.appcompat.app.AppCompatActivity
import com.bumptech.glide.Glide

const val SHARE_PREFERENCES_FIRST_LOGIN = "FIRST LOGIN"

class SplashActivity : AppCompatActivity() {

    private var firstLogin = true

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_splash)
        supportActionBar?.hide()

        showSpinnerGif()

        firstLogin = checkFirstLogin()

    }


    override fun onResume() {
        super.onResume()

        if (firstLogin) {
            setFirstLoginWithFalse()
            startDelayedMainActivity()
        } else
            startMainActivity()


    }


    private fun checkFirstLogin(): Boolean {
        val sharedPreferences = getPreferences(Context.MODE_PRIVATE)
        return sharedPreferences.getBoolean(SHARE_PREFERENCES_FIRST_LOGIN, true)
    }

    private fun showSpinnerGif() {
        val spinnerView = findViewById<ImageView>(R.id.spinnerVew)
        Glide.with(this).load(R.mipmap.spinner).into(spinnerView)
    }

    private fun startMainActivity() {
        val intent = Intent(applicationContext, MainActivity::class.java)
        startActivity(intent)
    }

    private fun startDelayedMainActivity() {
        android.os.Handler().postDelayed({
            startMainActivity()
        }, 1000)
    }

    private fun setFirstLoginWithFalse() {
        val editor = getPreferences(Context.MODE_PRIVATE).edit()
        editor.putBoolean(SHARE_PREFERENCES_FIRST_LOGIN, false)
        editor.apply()
    }
}