package main

// imports {{{
import (
	"os"
	// "fmt"
	"log"
	"gopkg.in/yaml.v3"
	"html/template"
)
// }}}

// yaml structure {{{

type ContactLinks struct {
	URL  string `yaml:"url"`
	Text string `yaml:"text"`
}

type JobLinks struct {
	Link string `yaml:"link"`
	Name string `yaml:"name"`
}

type Contact struct {
	Name     string        `yaml:"name"`
	Title    string        `yaml:"title"`
	Email    string        `yaml:"email"`
	Address  string        `yaml:"address"`
	Location string        `yaml:"location"`
	Phone    string        `yaml:"phone"`
	LinkedIn ContactLinks   `yaml:"linkedin"`
	GitLab   ContactLinks   `yaml:"gitlab"`
	GitHub   ContactLinks   `yaml:"github"`
	Website  ContactLinks   `yaml:"website"`
}

type Job struct {
	Position    string     `yaml:"position"`
	Company     JobLinks   `yaml:"company"`
	Product     JobLinks   `yaml:"product"`
	Description []string   `yaml:"description"`
	From        string     `yaml:"from"`
	To          string     `yaml:"to"`
	Tags        []string   `yaml:"tags"`
	Location    string     `yaml:"location"`
}

type Project struct {
	Name        string   `yaml:"name"`
	Text        string   `yaml:"text"`
	URL         string   `yaml:"url"`
	Description []string `yaml:"description"`
}

type EducationPlaceLink struct {
	Name string `yaml:"name"`
	Link string `yaml:"link"`
}

type Education struct {
	Place    EducationPlaceLink `yaml:"place"`
	Degree   string              `yaml:"degree"`
	Major    string              `yaml:"major"`
	Track    string              `yaml:"track"`
	From     string              `yaml:"from"`
	To       string              `yaml:"to"`
	Location string              `yaml:"location"`
}

type Achievement struct {
	Name        string `yaml:"name"`
	Description string `yaml:"description"`
}

type Blog struct {
	Contacts      Contact       `yaml:"contacts"`
	Position      string        `yaml:"position"`
	Tagline       []string      `yaml:"tagline"`
	Jobs          []Job         `yaml:"jobs"`
	Projects      []Project     `yaml:"projects"`
	Education     []Education    `yaml:"education"`
	Skills        []string      `yaml:"skills"`
	Tools         []string      `yaml:"tools"`
	Programming   []string      `yaml:"programming"`
	Languages     []string      `yaml:"languages"`
	Achievements  []Achievement `yaml:"achievements"`
}

// }}}

// html output {{{
func GenerateHTML(blog Blog) error {

	// Define a simple HTML template
	templateData, err := os.ReadFile("template.html")
	if err != nil {
		return err
	}

	// Create a new template and parse the HTML into it
	tmpl, err := template.New("blog").Parse(string(templateData))
	if err != nil {
		return err
	}

	// Create an HTML file
	file, err := os.Create("index.html")
	if err != nil {
		return err
	}
	defer file.Close()

	// Execute the template and write to the file
	err = tmpl.Execute(file, blog)
	if err != nil {
		return err
	}

	return nil
}
// }}}

// main {{{
func main() {
	// Read the YAML file
	data, err := os.ReadFile("configuration.yml")
	if err != nil {
		log.Fatalf("error: %v", err)
	}

	// Unmarshal the YAML data into the Blog struct
	var blog Blog
	err = yaml.Unmarshal(data, &blog)
	if err != nil {
		log.Fatalf("error: %v", err)
	}

	// // Print the parsed data (for demonstration purposes)
	// fmt.Printf("Name: %s\n", blog.Contacts.Name)
	// fmt.Printf("Position: %s\n", blog.Position)
	// fmt.Printf("Tagline: %s\n", blog.Tagline)
	// fmt.Printf("Jobs: %+v\n", blog.Jobs)
	// fmt.Printf("Projects: %+v\n", blog.Projects)
	// fmt.Printf("Education: %+v\n", blog.Education)
	// fmt.Printf("Skills: %+v\n", blog.Skills)
	// fmt.Printf("Tools: %+v\n", blog.Tools)
	// fmt.Printf("Programming: %+v\n", blog.Programming)
	// fmt.Printf("Languages: %+v\n", blog.Languages)
	// fmt.Printf("Achievements: %+v\n", blog.Achievements)

	GenerateHTML(blog)

}
// }}}

