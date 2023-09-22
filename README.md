# Airwaresales Air Condition Details Scraper

## Table of Contents

- [Description](#description)
- [Stacks](#stacks)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Description

The **airwaresales Air Condition Details Scraper** is a web scraping application built to extract air conditioning product details from [airwaresales.com.au](https://www.airwaresales.com.au/shop/) and store them in a structured format. This tool provides a convenient way to gather and organize information about air conditioning products available on the website.

## Stacks

- **Ruby on Rails 7**: The application is built using the Ruby on Rails framework, providing a robust and scalable web application structure.

- **Ruby 3**: The latest version of Ruby is used to power the application, ensuring performance and compatibility with modern libraries and tools.

- **PostgreSQL**: PostgreSQL is used as the database management system to efficiently store and manage the scraped data.

- **Containerization (Docker)**: The application is containerized using Docker, making it easy to package and deploy in various environments.

- **CI/CD Github Actions**: Continuous Integration and Continuous Deployment (CI/CD) pipelines are set up using GitHub Actions to automate testing and deployment processes.

- **AWS EC2 - Ubuntu instance**: The application is hosted on an Amazon Web Services (AWS) EC2 instance running Ubuntu, ensuring high availability and scalability.

- **SSL Let's Encrypt**: SSL encryption provided by Let's Encrypt ensures secure communication between users and the application.

## Installation

To run this application locally, follow these steps:

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/airwaresales.git
   cd airwaresales
   ```
2. Install Docker on your local machine if you haven't already: [Docker Installation Guide](https://docs.docker.com/get-docker/)

3. Build and run the Docker containers:
```
docker-compose up --build

```
4. Access the application in your browser at http://localhost:3000.

## License

This project is licensed under the MIT License.
