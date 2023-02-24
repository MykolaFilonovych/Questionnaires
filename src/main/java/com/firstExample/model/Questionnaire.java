package com.firstExample.model;

import java.util.Objects;

public class Questionnaire
{
    //public enum Gender {MALE, FEMALE}

    private String lastName;
    private String firstName;
    private String pathronim;
    private int birthYear;
    private String gender;
    private String job;

    public Questionnaire()
    {

    }

    public Questionnaire(String lastName, String firstName, String pathronim, int birthYear, String gender, String job) {
        this.lastName = lastName;
        this.firstName = firstName;
        this.pathronim = pathronim;
        this.birthYear = birthYear;
        this.gender = gender;
        this.job = job;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getPathronim() {
        return pathronim;
    }

    public void setPathronim(String pathronim) {
        this.pathronim = pathronim;
    }

    public int getBirthYear() {
        return birthYear;
    }

    public void setBirthYear(int birthYear) {
        this.birthYear = birthYear;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getJob() {
        return job;
    }

    public void setJob(String job) {
        this.job = job;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Questionnaire that = (Questionnaire) o;
        return birthYear == that.birthYear && lastName.equals(that.lastName)
                && firstName.equals(that.firstName) && pathronim.equals(that.pathronim)
                && gender == that.gender && job.equals(that.job);
    }

    @Override
    public int hashCode() {
        return Objects.hash(lastName, firstName, pathronim, birthYear, gender, job);
    }

    public String toString()
    {
//        String gender0 = this.gender==Gender.MALE ? "Чол." : "Жін.";
        return "[" + this.lastName + " " + this.firstName + " " + this.pathronim + ", рік народження - " +
                this.birthYear + ", стать - " + this.gender + ", рід занять - " + this.job + "]";
    }
}
