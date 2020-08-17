package com.example.cltcalculator

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.google.android.material.button.MaterialButton
import com.google.android.material.textfield.TextInputEditText

const val EXTRA_BRUTE_SALARY = "BRUTE SALARY"
const val EXTRA_ANOTHER_DISCOUNTS = "ANOTHER DISCOUNTS"
const val EXTRA_NUMBER_OF_DEPENDENCY = "NUMBER OF DEPENDENCY"


class MainActivity : AppCompatActivity() {


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        setEditTextListeners()
    }

    private fun setEditTextListeners() {

        val textInputs = listOf<TextInputEditText>(
            findViewById(R.id.bruteSalaryTextInput),
            findViewById(R.id.numberOfDependenciesTextInput),
            findViewById(R.id.anotherDiscountsTextInput)
        )


        textInputs.forEach { setKeyListener(it) }


        val calculateCLTButton = findViewById<MaterialButton>(R.id.cltCalculateButton)


        calculateCLTButton.setOnClickListener {
            val emptyInputs = textInputs.filter { isEmpty(it) }
            if (emptyInputs.isEmpty().not())
                return@setOnClickListener


            startResultActivity(textInputs)

            textInputs.forEach {it.text = null}

            return@setOnClickListener
        }
    }


    private fun isEmpty(inputText: TextInputEditText): Boolean {
        val text = inputText.text
        val empty = !(text != null && text.isNotEmpty())

        if (empty)
            inputText.error = getString(R.string.empty_field)

        return empty
    }

    private fun setKeyListener(inputText: TextInputEditText) {
        inputText.setOnKeyListener { _, _, _ ->

            if (isEmpty(inputText).not()) {
                inputText.error = null
            }

            false

        }
    }


    private fun startResultActivity(inputs: List<TextInputEditText>) {

        val bruteSalary = inputs.first().text.toString().toDouble()
        val numberOfDependency = inputs[1].text.toString().toDouble()
        val anotherDiscounts = inputs.last().text.toString().toDouble()

        val intent = Intent(this, ResultActivity::class.java).apply {
            putExtra(EXTRA_BRUTE_SALARY, bruteSalary)
            putExtra(EXTRA_NUMBER_OF_DEPENDENCY, numberOfDependency)
            putExtra(EXTRA_ANOTHER_DISCOUNTS, anotherDiscounts)
        }

        startActivity(intent)
    }


}