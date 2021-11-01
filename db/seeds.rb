duds = [
    {
      name: "Napoleon", 
      age:44,
      hobbies: "Comics"
    },
    {
      name: "Kevin",
      age:22,
      hobbies: "Trucking"
    },
    {
      name: "Anthony",
      age:32,
      hobbies: "Sleeping"
    },
    {
      name: "Brandon",
      age:27,
      hobbies: "Fighting with mom"
    },
    {
      name: "Ross",
      age:18,
      hobbies: "Collecting cowboy hats"
    },
    {
      name: "John",
      age:21,
      hobbies: "Comics"
    },
    {
      name: "Phil",
      age:34,
      hobbies: "Sleeping"
    },
    {
      name: "Ato", 
      age:23,
      hobbies: "Dancing"
    }
    
]

  

duds.each do |attributes|
    Dud.create attributes
    p "creating duds #{attributes}"
end

