package com.example.igtiquiz

import android.content.Context


class QuestionsFromTXT(private val context: Context) {


    private val txtFileName = "Perguntas.txt"

    fun load(): List<Question> {

        val lines = context.assets.open(txtFileName).bufferedReader().readLines()

        val questions = mutableListOf<Question>()
        lines.forEach {
            val strings = it.split(";")
            val text = strings.first()
            val answer = strings.last().indexOf("true") != -1

            questions.add(Question(text, answer))
        }


        return questions.toList()
    }
}