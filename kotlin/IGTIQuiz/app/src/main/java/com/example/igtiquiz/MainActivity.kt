package com.example.igtiquiz

import android.annotation.SuppressLint
import android.content.Intent
import android.os.Bundle
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.google.android.material.button.MaterialButton

const val EXTRA_RIGHT_ANSWERS_PERCENTAGE = "RIGHT ANSWERS PERCENTAGE"

class MainActivity : AppCompatActivity() {

    private lateinit var questions: List<Question>

    private lateinit var questionView: TextView

    private var currentIndexQuestion = 0

    private var rightAnswers = 0

    @SuppressLint("CheckResult", "ShowToast")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        questionView = findViewById(R.id.questionTextView)

        questions = QuestionsFromTXT(applicationContext).load()

        setQuestion(questions.first())

        setListenerButtons()

    }

    private fun setQuestion(question: Question) {
        questionView.text = question.text
    }


    private fun setListenerButtons() {
        val trueButton = findViewById<MaterialButton>(R.id.trueButton)
        val falseButton = findViewById<MaterialButton>(R.id.falseButton)

        trueButton.setOnClickListener {
            onClickListener(true)

        }
        falseButton.setOnClickListener {
            onClickListener(false)
        }
    }

    private fun nextQuestion() {
        currentIndexQuestion++
        setQuestion(questions[currentIndexQuestion])
    }

    private fun onClickListener(userAnswer: Boolean) {
        checkAnswer(userAnswer)
        if (currentIndexQuestion + 1 == questions.size)
            startResultActivity()
        else
            nextQuestion()


    }

    private fun checkAnswer(userAnswer: Boolean) {
        if (userAnswer == questions[currentIndexQuestion].answer) {
            showCorrectAnswerToast()
            rightAnswers++
        } else
            showWrongAnswerToast()


    }


    private fun startResultActivity() {

        val rightAnswersPercentage = rightAnswers.toDouble() / questions.size * 100

        val intent = Intent(applicationContext, ResultActivity::class.java)
        intent.putExtra(EXTRA_RIGHT_ANSWERS_PERCENTAGE, rightAnswersPercentage)

        startActivity(intent)

    }

    private fun showCorrectAnswerToast() {
        Toast.makeText(
            applicationContext, getString(R.string.correct_answer),
            Toast.LENGTH_SHORT
        ).show()

    }

    private fun showWrongAnswerToast() {
        Toast.makeText(applicationContext, getString(R.string.wrong_answer), Toast.LENGTH_SHORT)
            .show()
    }
}