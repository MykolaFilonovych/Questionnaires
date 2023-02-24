<%@ page import="com.firstExample.DAO.QuestionnaireDAO" %>
<%@ page import="com.mongodb.client.MongoCollection" %>
<%@ page import="org.bson.Document" %>
<%@ page import="com.mongodb.client.FindIterable" %>
<%@ page import="com.mongodb.client.MongoCursor" %>
<%@ page import="java.util.*" %>
<%@ page import="com.firstExample.UpdateChecker" %>
<%@ taglib prefix="th" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c0" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Анкети</title>
        <script>
            let toDo = ""; // Допоміжна змінна, яка вказує, що потрібно робити з вибраною анкетою

            function makeFormVisible()
            {
                const form = document.getElementById("Questionnaire_form");
                if(form.style.visibility==="hidden")
                {
                    form.style.visibility="visible";
                }
            }
            function hideForm()
            {
                const form = document.getElementById("Questionnaire_form");
                if(form.style.visibility==="visible")
                {
                    form.style.visibility="hidden";
                }
                if(document.getElementById("saveData").value !=="Зберегти")
                {
                    document.getElementById("saveData").value="Зберегти";
                }
                if(toDo==="delete")
                {
<%--                    <%--%>
<%--                        QuestionnaireDAO.setAction("delete");--%>
<%--                    %>--%>
                }
                // не вдалося узгодити зв'язок між Java та JavaScript кодом, тому що при завантаженні сторінки
                // код в скриплетах (теги < % % >) виконувався навіть якщо не було викликано JavaScript функції
                // в якій поміщався Java код в скриплетах
                if(toDo==="update") // не вдалося встановити звязок між Java та JavaScript кодом.
                {
<%--                    <%--%>
<%--                        QuestionnaireDAO.setAction("update");--%>
<%--                    %>--%>
                }
                toDo="";
            }
            function fillForm(text)
            {
                makeFormVisible();
                let array = text.split(",");
                document.getElementById("p").value=array[1];
                document.getElementById("i").value=array[2];
                document.getElementById("b").value=array[3];
                document.getElementById("by").value=array[4];
                if(array[5]==="Male")
                {
                    document.getElementById("m").checked = true;
                }
                else
                    {
                        document.getElementById("f").checked = true;
                    }
                document.getElementById("jobs").value=array[6];
            }

            function deleteQuestionnaire(text)
            {
                fillForm(text);
                document.getElementById("saveData").value="Видалити";
            }

            function addQuestionnaireOnMouseMove()
            {
                document.getElementById("addQuestionnaire").style.animationDelay="3s";
                document.getElementById("addQuestionnaire").style.background="mediumseagreen";
            }
            function addQuestionnaireOnMouseLeave()
            {
                document.getElementById("addQuestionnaire").style.animationDelay="3s";
                document.getElementById("addQuestionnaire").style.background="greenyellow";
            }

            function saveButtonOnMouseMove()
            {
                document.getElementById("saveData").style.background="red";
            }
            function saveButtonOnMouseLeave()
            {
                document.getElementById("saveData").style.background="firebrick";
            }
        </script>
    </head>
    <body>
        <h1 align="center">Сторінка з анкетами</h1>
        <button onmousemove="addQuestionnaireOnMouseMove()" onmouseleave="addQuestionnaireOnMouseLeave()"
                onclick="makeFormVisible()" style="font-weight: bold; margin-left:50px; background: greenyellow;
                color: darkgreen; border-radius: 5px; width: 160px; height: 40px; cursor: pointer"
                id="addQuestionnaire">Додати анкету</button><br>

        <form method="post" action="/Questionnaires" style="margin-left:50px; margin-top:50px; background: chocolate; border: 2px black solid;
            width: 360px; height: 210px; padding: 20px; visibility: hidden" id="Questionnaire_form">

            <input id="p" type="text" placeholder="Прізвище" name="LastName" style="margin-bottom: 10px; height: 25px"/>
            <input id="i" type="text" placeholder="Ім'я" name="FirstName" style="margin-left: 10px; margin-bottom: 10px; height: 25px"/><br/>
            <input id="b" type="text" placeholder="По-батькові" name="Pathronim" style="margin-bottom: 10px; height: 25px"/>
            <input id="by" type="number" placeholder="Рік народження" name="BirthYear" style="margin-left: 10px; margin-bottom: 30px"/><br/>

            <label style="font-weight: bold; color: blue; margin-right: 15px; margin-top: 60px">Стать</label>
            <div style="margin-left: 50px; margin-top: -30px; margin-bottom: 10px">
                <input type="radio" id="m" placeholder="Стать" name="Gender" value="Male" style="margin-bottom: 10px"/>
                <label for="m" style="color:yellow">Чол.</label><br/>
                <input type="radio" id="f" placeholder="Стать" name="Gender" value="Female" style="margin-bottom: 10px"/>
                <label for="f" style="color:yellow">Жін.</label>
            </div>

            <label for="jobs" style="color: darkgreen; font-weight: bold">Рід занять</label>
            <select typeof="text" name="Job" id="jobs" style="width: 240px;margin-left:15px; margin-bottom: 15px">
                <option value=""></option>
                <option value="Medicine">Medicine</option>
                <option value="Banking">Banking</option>
                <option value="Education">Education</option>
                <option value="Trading">Trading</option>
                <option value="IT">IT</option>
                <option value="Logistics">Logistics</option>
                <option value="Public transport driver">Public transport driver</option>
                <option value="Security">Security</option>
                <option value="Cafes/Restaurants">Cafes/Restaurants</option>
                <option value="Hotels">Hotels</option>
                <option value="Lawyers">Lawyers</option>
                <option value="Building/Architecture">Building/Architecture</option>
                <option value="Accounting/Taxes">Accounting/Taxes</option>
            </select>
            <br/>
            <input onmousemove="saveButtonOnMouseMove()" onmouseleave="saveButtonOnMouseLeave()"
                   type="submit" style="float:right; margin-right: 20px; background: firebrick;
                    color: cyan; height: 25px; width: 80px; border-radius: 5px; cursor: pointer"
                    onclick="hideForm()" value="Зберегти" id="saveData"/>
        </form>

        <%
            MongoCollection<Document> questionnaires = QuestionnaireDAO.getQuestionnaires();
            long questionnairesQuantity = questionnaires.countDocuments();

            List<String> pibs = new ArrayList<>();
            List<String> data0 = new ArrayList<>();
            List<String> ids = new ArrayList<>();
            FindIterable<Document> findIterable = questionnaires.find();

            try (MongoCursor<Document> cursor = findIterable.iterator())
            {
                String pib = "";
                String dataFromQuestionnaire = "";
                while (cursor.hasNext()) {
                    Document document = cursor.next();
                    String id = document.get("_id").toString();
                    ids.add(id);

                    String lastname = document.get("lastname").toString();
                    String firstname = document.get("firstname").toString();
                    String pathronim = document.get("pathronim").toString();
                    int birthYear = Integer.parseInt(document.get("birthYear").toString());
                    String gender = document.get("gender").toString();
                    String job = document.get("job").toString();

                    pib = lastname + " " + firstname + " " + pathronim;

                    dataFromQuestionnaire = id+","+lastname+","+firstname+","+pathronim+
                            ","+birthYear+","+gender+","+job;

                    data0.add(dataFromQuestionnaire);
                    pibs.add(pib);
                }
            }

            if(questionnairesQuantity!=0)
            {
                for(int i = 0; i < questionnairesQuantity; i+=1) { %>

                    <div id="<%=ids.get(i)%>" style="margin-left: 30px; width: 500px; height: 100px; background: pink;
                     border: red 5px solid; margin-bottom: 25px">

                        <p style="margin-left: 15px"><%= pibs.get(i)%></p>

                        <button onclick="deleteQuestionnaire('<%=data0.get(i)%>');toDo='delete'<% new UpdateChecker().setId(data0.get(i).split(",")[0]);%>" style="cursor: pointer; margin-right: 20px; border-radius: 4px; width: 80px;
                                height: 30px; background: darkorange; color: darkred; float: right">Видалити</button>

                        <button onclick="fillForm('<%=data0.get(i)%>');toDo='update'<% new UpdateChecker().setId(data0.get(i).split(",")[0]); %>" style="cursor: pointer; margin-right: 20px;
                                border-radius: 4px; width: 80px; height: 30px; background: #00008b; color: cyan;
                                float: right">Оновити</button>
                    </div>
            <% }
            }
            else{%>
            <h1>У базі поки що немає анкет!</h1>
        <%
        }
    %>
    </body>
</html>
