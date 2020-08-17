package com.example.cltcalculator

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.google.android.material.button.MaterialButton
import com.google.android.material.textview.MaterialTextView

class ResultActivity : AppCompatActivity() {


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_result)


        val views = findViews()
        val values = calculateDiscounts()
        setTextInViews(views, values)

        setBackButtonListener()

    }

    private fun setBackButtonListener() {
        findViewById<MaterialButton>(R.id.backButton).setOnClickListener {
            startMainActivity()
        }
    }

    private fun setTextInViews(views: List<MaterialTextView>, values: List<Double>) {
        for (index in 0 until views.size - 1) {
            views[index].text = "%.2f".format(values[index])
        }

        views.last().text = "%.2f".format(values.last()) + "%"
    }

    private fun startMainActivity() {
        val intent = Intent(this, MainActivity::class.java)
        startActivity(intent)

    }


    private fun findViews(): List<MaterialTextView> {

        return listOf(
            findViewById(R.id.bruteSalaryTextView),
            findViewById(R.id.inssTextView),
            findViewById(R.id.irrfTextView),
            findViewById(R.id.anotherDiscountsTextView),
            findViewById(R.id.liquidSalaryTextView),
            findViewById(R.id.discountsTextView)
        )

    }

    private fun calculateDiscounts(): List<Double> {
        val bruteSalary = intent.getDoubleExtra(EXTRA_BRUTE_SALARY, 0.0)
        val inss = inssDiscount(bruteSalary)
        val baseValue = baseValueIrrf(bruteSalary, inss)
        val irrf = irrfDiscount(baseValue)
        val anotherDiscounts = intent.getDoubleExtra(EXTRA_ANOTHER_DISCOUNTS, 0.0)
        val liquidSalary = bruteSalary - inss - irrf - anotherDiscounts
        val discounts = (inss + irrf) / bruteSalary * 100

        return listOf(
            bruteSalary,
            -inss,
            -irrf,
            -anotherDiscounts,
            liquidSalary,
            discounts
        )

    }


    private fun inssDiscount(bruteSalary: Double): Double {
        val inssAliquots = listOf(0.075, 0.09, 0.12, 0.14)
        val inssDeductions = listOf(0.0, 15.67, 78.36, 141.05)
        val inssSalaryThresholds = listOf(1045.00, 2089.60, 3134.40, 6101.06)


        for (index in inssAliquots.indices) {
            if (bruteSalary <= inssSalaryThresholds[index]) {
                return inssAliquots[index] * bruteSalary - inssDeductions[index]
            }
        }

        return 713.10

    }

    private fun irrfDiscount(baseValue: Double): Double {
        val irrfAliquots = listOf(0.0, 0.075, 0.15, 0.225)
        val irrfDeductions = listOf(0.0, 142.80, 354.80, 636.13)
        val irrfSalaryThresholds = listOf(1903.98, 2826.65, 3751.05, 4664.68)

        for (index in irrfAliquots.indices) {
            if (baseValue <= irrfSalaryThresholds[index]) {
                return irrfAliquots[index] * baseValue - irrfDeductions[index]
            }
        }


        val maxAliquot = 0.275

        val maxDeduction = 869.36

        return baseValue * maxAliquot - maxDeduction

    }

    private fun baseValueIrrf(bruteSalary: Double, inss: Double): Double {
        val numberOfDependencies = intent.getDoubleExtra(EXTRA_NUMBER_OF_DEPENDENCY, 0.0)
        return bruteSalary - inss - numberOfDependencies * 189.59
    }
}