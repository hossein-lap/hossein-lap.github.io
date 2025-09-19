package main

// imports {{{
import (
	"os"
	"fmt"
	"log"
	"gopkg.in/yaml.v3"
	"html/template"
)
// }}}

// yaml structure {{{

type ContactLinks struct {
	Name string `yaml:"name"`
	URL  string `yaml:"url"`
	Text string `yaml:"text"`
}

type JobLinks struct {
	Link string `yaml:"link"`
	Name string `yaml:"name"`
}

type Contact struct {
	Name     string         `yaml:"name"`
	Title    string         `yaml:"title"`
	Email    string         `yaml:"email"`
	Address  string         `yaml:"address"`
	Location string         `yaml:"location"`
	Phone    string         `yaml:"phone"`
    Links    []ContactLinks `yaml:"links"`
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
	data, err := os.ReadFile("resume.yml")
	if err != nil {
		log.Fatalf("// error: %v", err)
	}

	// Unmarshal the YAML data into the Blog struct
	var blog Blog
	err = yaml.Unmarshal(data, &blog)
	if err != nil {
		log.Fatalf("// error: %v", err)
	}


	// // Print the parsed data (for demonstration purposes)
	// fmt.Println("= Blog Summary\n")
	// fmt.Println("== Contacts\n")
	// fmt.Printf("* Name: %s\n", blog.Contacts.Name)
	// fmt.Printf("* Title: %s\n", blog.Contacts.Title)
	// fmt.Printf("* Email: %s\n", blog.Contacts.Email)
	// fmt.Printf("* Phone: %s\n", blog.Contacts.Phone)
	// fmt.Printf("* Address: %s\n", blog.Contacts.Address)
	// fmt.Printf("* Location: %s\n", blog.Contacts.Location)
	// fmt.Println("\n=== Links\n")
	// for _, link := range blog.Contacts.Links {
	// 	fmt.Printf("* %s: %s (%s)\n", link.Name, link.Text, link.URL)
	// }
	// fmt.Println("\n== Tagline\n")
	// for _, tagline := range blog.Tagline {
	// 	fmt.Printf("* %s\n", tagline)
	// }
	// fmt.Println("\n== Jobs\n")
	// for _, job := range blog.Jobs {
	// 	fmt.Printf("* %s at %s (%s -> %s)\n", job.Position, job.Company.Name, job.From, job.To)
	// 	for _, desc := range job.Description {
	// 		fmt.Printf("** %s\n", desc)
	// 	}
	// }
	// fmt.Println("\n== Projects\n")
	// for _, project := range blog.Projects {
	// 	fmt.Printf("* %s (%s)\n", project.Name, project.URL)
	// 	for _, desc := range project.Description {
	// 		fmt.Printf("** %s\n", desc)
	// 	}
	// }
	// fmt.Println("\n== Education\n")
	// for _, edu := range blog.Education {
	// 	fmt.Printf("* %s, %s in %s (%s -> %s, %s)\n", edu.Place.Name, edu.Degree, edu.Major, edu.From, edu.To, edu.Location)
	// }
	// fmt.Println("\n== Skills\n")
	// for _, skill := range blog.Skills {
	// 	fmt.Printf("* %s\n", skill)
	// }
	// fmt.Println("\n== Tools\n")
	// for _, tool := range blog.Tools {
	// 	fmt.Printf("* %s\n", tool)
	// }
	// fmt.Println("\n== Programming\n")
	// for _, lang := range blog.Programming {
	// 	fmt.Printf("* %s\n", lang)
	// }
	// fmt.Println("\n== Languages\n")
	// for _, lang := range blog.Languages {
	// 	fmt.Printf("* %s\n", lang)
	// }
	// fmt.Println("\n== Achievements\n")
	// for _, ach := range blog.Achievements {
	// 	fmt.Printf("* %s: %s\n", ach.Name, ach.Description)
	// }
	// fmt.Println("\n// HTML generation completed successfully!")

	fmt.Println("Octave!")

	GenerateHTML(blog)  // generate index.html

}
// }}}

