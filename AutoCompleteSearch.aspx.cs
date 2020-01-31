using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AutoCompleteSearch : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSearch_btn_Click(object sender, EventArgs e)
    {
        string user_name = UserName_hf.Value;

        if (!string.IsNullOrEmpty(user_name))
        {
            //write code after search selection
        }

    }

    [System.Web.Services.WebMethod]
    public static string GetJSON(string search_term)
    {
        string res = string.Empty;

        res = GetStudentAutoComplete(search_term);

        return res;
    }

    public static string GetStudentAutoComplete(string search_term)
    {

        List<Student> list = new List<Student>( );

        list.Add(new Student { id=1, name="Akash Verma", City= "Kolkata", phone="1234567890",salary="$1500"});
        list.Add(new Student { id=1, name="Bishva", City= "Delhi", phone="1234567890",salary="$1500"});
        list.Add(new Student { id=1, name="Deepak", City= "Chandigarh", phone="1234567890",salary="$1500"});
        list.Add(new Student { id=1, name="Sandeep", City= "Aligarh", phone="1234567890",salary="$1500"});
        list.Add(new Student { id=1, name="Sushil", City= "Jaipur", phone="1234567890",salary="$1500"});
        list.Add(new Student { id=1, name="Arvind", City= "Varanasi", phone="1234567890",salary="$1500"});
        list.Add(new Student { id=1, name="Jitendra", City= "Patna", phone="1234567890",salary="$1500"});
        list.Add(new Student { id=1, name="Prashant", City= "Varanasi", phone="1234567890",salary="$1500"});
        list.Add(new Student { id=1, name="Mukesh", City= "Gurgaon", phone="1234567890",salary="$1500"});
        list.Add(new Student { id=1, name="Ashutosh", City= "Gaziabad", phone="1234567890",salary="$1500"});
           
        string json_object = "[";

            foreach(Student student in list)
            {

                json_object += "{\"id\":\"" + student.id.ToString() + "\",\"name\":\"" + student.name + "\",\"city\":\"" + student.City + "\",\"phone\":\"" + student.phone + "\",\"salary\":\"" + student.salary + "\"},";
            }
                    

                    json_object = json_object.Substring(0, json_object.LastIndexOf(","));
                    json_object += "]";
                
        
        
        
        return json_object;
    }

    class Student
    {
        public int id { get; set; }
        public string name { get; set; }
        public string City { get; set; }
        public string phone { get; set; }
        public string salary { get; set; }
    }
}