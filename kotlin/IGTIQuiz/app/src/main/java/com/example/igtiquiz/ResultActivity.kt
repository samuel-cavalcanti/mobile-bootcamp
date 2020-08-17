package com.example.igtiquiz

import android.content.Intent
import android.os.Bundle
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import com.google.android.material.button.MaterialButton

class ResultActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_result)

        setOnclickListener()
        setRightAnswersPercentage()
    }

    private fun setOnclickListener() {
        val restartButton = findViewById<MaterialButton>(R.id.restartButton)
        restartButton.setOnClickListener { startMainActivity() }
    }

    private fun startMainActivity() {
        val intent = Intent(applicationContext, MainActivity::class.java)
        startActivity(intent)
    }


    private fun setRightAnswersPercentage() {
        val percentage = intent.getDoubleExtra(EXTRA_RIGHT_ANSWERS_PERCENTAGE, 0.0)
        val answersPercentage = findViewById<TextView>(R.id.rightAnswerPercentageView)
        answersPercentage.text = "%.0f".format(percentage) + "%"
    }
}