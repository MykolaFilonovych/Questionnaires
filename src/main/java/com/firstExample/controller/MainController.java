package com.firstExample.controller;

import com.firstExample.DAO.QuestionnaireDAO;
import com.firstExample.model.Questionnaire;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class MainController
{
    @Autowired
    QuestionnaireDAO questionnaireDAO;

    public MainController()
    {
        this.questionnaireDAO = new QuestionnaireDAO();
    }

    @RequestMapping(value = "/Questionnaires", method = RequestMethod.GET)
    public String getQuestionnaires()
    {
        return "Questionnaires";
    }

    @RequestMapping(value = "/Questionnaires", method = RequestMethod.POST)
    public void saveQuestionnaire(@ModelAttribute("questionnaire") Questionnaire questionnaire, ModelMap model)
    {
        model.addAttribute("lastName", questionnaire.getLastName());
        model.addAttribute("firstName", questionnaire.getFirstName());
        model.addAttribute("pathronim", questionnaire.getPathronim());
        model.addAttribute("birthYear", questionnaire.getBirthYear());
        model.addAttribute("gender", questionnaire.getGender());
        model.addAttribute("job", questionnaire.getJob());

        questionnaireDAO.actWithQuestionnaire(questionnaire);
    }

    @RequestMapping(value = "/Questionnaires", method = RequestMethod.DELETE)
    public void deleteQuestionnaire(String id)
    {
        questionnaireDAO.deleteQuestionnaire(id);
    }
}
