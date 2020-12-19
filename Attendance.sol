pragma solidity >= 0.0.0 <0.8.0 ;
pragma experimental ABIEncoderV2 ;

contract Attendance
{
    //A address-boolean pair of admins
    mapping(address => bool) AdminHashes ;
    
    constructor()
    {
        AdminHashes[msg.sender] = true ;
    }
    
    //student structure
    struct Student
    {
        int rollno ;
        string name ;
        int age ;
        string course ;
        int attendance ;
    }
    
    //A rollno-Student mapping
    mapping(int => Student) students ;
  
    //Authentication2(only )
    modifier Admin
    {
        require(AdminHashes[msg.sender] == true);
        _;
        
    }
    
    //Funnction for adding student with initial values
    
    function addStudent(int _rollno ,string  memory _name,int _age,string memory _course ,int _attendance) public Admin returns (string memory)
    {
            students[ _rollno] = Student(_rollno,_name,_age,_course,_attendance) ;
            return "Successfully added" ;
        
    }
    
    //View one student
    function viewStudent(int _rollno ) view public returns(Student memory)
    {
        return students[_rollno];
    }
    

    
    //add Attendance of a student by roll number
    function addAttendance(int _rollno) public Admin
    {
        students[_rollno].attendance+=1 ;
    }
    
    //View attendance of a student by roll number
    function viewAttendance(int _rollno) view public returns(int , string memory ,int )
    {
        
        return (students[_rollno].rollno,  students[_rollno].name , students[_rollno].attendance);
    }
    
    //Add admin to the adminhash
    function addAdmin(address adr) public Admin
    {
            AdminHashes[adr] = true ;   
    }
    
}