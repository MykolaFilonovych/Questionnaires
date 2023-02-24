package com.firstExample.DAO;

import com.firstExample.UpdateChecker;
import com.firstExample.model.Questionnaire;
import com.mongodb.*;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import org.springframework.jdbc.core.JdbcTemplate;

public class QuestionnaireDAO
{
    JdbcTemplate jdbcTemplate;

    MongoClient mongoClient;
    MongoDatabase database;
    private static MongoCollection<Document> questionnaires;
    private static String action = "";

    public QuestionnaireDAO()
    {
        jdbcTemplate = new JdbcTemplate();
        mongoClient = new MongoClient("localhost", 27017);
        database = mongoClient.getDatabase("firstDatabase");
        questionnaires = database.getCollection("Questionnaires");
    }

    public QuestionnaireDAO(JdbcTemplate jdbcTemplate)
    {
        this.jdbcTemplate = jdbcTemplate;
    }

    public static void setAction(String _act)
    {
        action = _act;
    }

    public void actWithQuestionnaire(Questionnaire q)
    {
        String record = "{'lastname': '" + q.getLastName() + "', 'firstname': '" + q.getFirstName() +
                "', 'pathronim': '" + q.getPathronim() + "', 'birthYear': " + q.getBirthYear() +
                ", 'gender': '" + q.getGender() + "', 'job': '" + q.getJob() + "'}";

        Document document = Document.parse(record);

        try
        {
            if(action.contains("delete"))
            {
                questionnaires.deleteOne(document);
            }
            else if(action.contains("update")) // Не вдалося створити функціональність для оновлення анкет
            {
                //questionnaires.updateOne(document, document);
            }
            else
                {
                    questionnaires.insertOne(document);
                }
            action = "";
            System.out.println("id = " + new UpdateChecker().getId());
        }
        catch (MongoException mongoException)
        {
            mongoException.printStackTrace();
        }
    }

    public static MongoCollection<Document> getQuestionnaires()
    {
        return questionnaires;
    }

    public void deleteQuestionnaire(Object id)
    {
        String record = "{'_id': '" + id + "'}";
        Document document = Document.parse(record);
        questionnaires.deleteOne(document);
    }
}
