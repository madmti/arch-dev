package main

import (
	"bufio"
	"fmt"
	"os"
	"path/filepath"
	"strings"
	"sync"
)

var appDirs = []string{
	"/usr/share/applications",
	"/usr/local/share/applications",
	os.Getenv("HOME") + ".local/share/applications",
}

func main() {
	var wg sync.WaitGroup
	results := make (chan string, 100)
	for _, dir := range appDirs {
		wg.Add(1)
		go func (d string) {
			defer wg.Done()
			scanDirectory(d, results)
		}(dir)
	}

	go func() {
		wg.Wait()
		close(results)
	}()

	for item := range results {
		fmt.Println(item)
	}

}

func scanDirectory(path string, out chan<- string) {
	files, err := os.ReadDir(path)
	if err != nil {
		return
	}

	for _, file := range files {
		if filepath.Ext(file.Name()) == ".desktop" {
			parseDesktopFile(filepath.Join(path, file.Name()), out)
		}
	}
}

func parseDesktopFile(path string, out chan<- string) {
	file, err := os.Open(path)
	if err != nil {
		return
	}
	defer file.Close()

	var name, exec string
	scanner := bufio.NewScanner(file)

	for scanner.Scan() {
		line := scanner.Text()

		if strings.HasPrefix(line, "Name=") && name == "" {
			name = strings.TrimPrefix(line, "Name=")
		} else if strings.HasPrefix(line, "Exec=") && exec == "" {
			exec = strings.TrimPrefix(line, "Exec=")
			idx := strings.Index(exec, "%")
			if idx != -1 {
				exec = exec[:idx]
			}
			exec = strings.TrimSpace(exec)
		}
		if name != "" && exec != "" {
			out <- fmt.Sprintf("%s\t%s", name, exec)
			return
		}
	}
}

