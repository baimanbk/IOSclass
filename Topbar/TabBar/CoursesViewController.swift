import UIKit

final class CoursesViewController: UITableViewController {

    private var items: [FavoriteItem] = [
        FavoriteItem(
            title: "iOS Development",
            imageName: "c1",
            description: "This course introduces the foundations of mobile app development using Swift and Xcode. Students learn how to design user interfaces, manage data, and integrate APIs. Practical labs include building complete applications with navigation, persistence, and animation. The course emphasizes Apple’s Human Interface Guidelines for intuitive design. By the end, learners can publish their own apps and understand the fundamentals of iOS architecture.",
            review: "Practical, creative, and highly rewarding."
        ),
        FavoriteItem(
            title: "Data Mining",
            imageName: "c2",
            description: "The course explores how to extract useful patterns and knowledge from large datasets. Students study clustering, classification, regression, and association rule techniques. Real-world projects include analyzing data from social media and business systems. Emphasis is placed on data preprocessing and result interpretation. By the end, students understand how to transform raw data into actionable insights.",
            review: "Analytical, hands-on, and essential for modern tech."
        ),
        FavoriteItem(
            title: "Cybersecurity Management",
            imageName: "c3",
            description: "This course focuses on how organizations protect digital assets through governance and security strategy. Topics include threat analysis, policy creation, and incident response. Students learn how to align security measures with business goals. Real cases illustrate both technical and managerial approaches to cybersecurity. Graduates understand how to manage risk and ensure compliance with global standards.",
            review: "Strategic, security-focused, and business-relevant."
        ),
        FavoriteItem(
            title: "Cloud Applications",
            imageName: "c4",
            description: "Students learn how to build and deploy applications on cloud platforms such as AWS and Google Cloud. The course covers scalability, microservices, and containerization. Hands-on labs guide learners through hosting APIs, automating infrastructure, and optimizing cost. It also emphasizes DevOps practices and continuous integration. Graduates can design reliable, secure, and efficient cloud-based systems.",
            review: "Technical, innovative, and future-oriented."
        ),
        FavoriteItem(
            title: "Business IT Architecture",
            imageName: "c5",
            description: "This course explores how enterprise IT systems are structured to support business strategy. Students study frameworks like TOGAF and analyze system integration. Case studies demonstrate how IT architecture enables digital transformation. Emphasis is placed on balancing flexibility, performance, and cost. By the end, learners can model complex IT ecosystems and propose improvement roadmaps.",
            review: "Comprehensive, structured, and strategic."
        ),
        FavoriteItem(
            title: "Innovation Management",
            imageName: "c6",
            description: "This course teaches how companies create and sustain innovation in a competitive world. Students learn frameworks for creativity, product design, and strategic change. Real-world examples show how startups and corporations innovate differently. The program emphasizes both leadership and team collaboration in innovation processes. By the end, students know how to transform ideas into impactful solutions.",
            review: "Inspiring, strategic, and full of creative energy."
        ),
        FavoriteItem(
            title: "IT Risk, Cybersecurity, and Governance",
            imageName: "c7",
            description: "This integrated course combines risk management, cybersecurity, and corporate governance. Students learn how to identify, assess, and mitigate technology risks. It covers compliance frameworks such as ISO/IEC 27001 and NIST. Case studies illustrate how governance supports ethical and secure decision-making. Graduates are prepared to design resilient IT risk frameworks for organizations.",
            review: "Comprehensive, policy-driven, and essential for leaders."
        ),
        FavoriteItem(
            title: "UX/UI Design",
            imageName: "c8",
            description: "Students explore how design thinking and human-centered design shape digital experiences. The course covers usability principles, prototyping, and user testing. Learners apply tools like Figma to create interactive interfaces. Emphasis is placed on accessibility and emotional design. By the end, students can design products that are both beautiful and functional.",
            review: "Creative, practical, and user-focused."
        ),
        FavoriteItem(
            title: "Introduction to Management",
            imageName: "c9",
            description: "This course provides a foundation in organizational management and leadership. Students learn about planning, decision-making, motivation, and team dynamics. Case studies help connect theory with real-world business challenges. The course also explores communication and ethical leadership. Graduates understand how to lead effectively and manage organizational change.",
            review: "Foundational, insightful, and leadership-oriented."
        )
    ]


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Courses"
        tableView.rowHeight = 80
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath)
        let item = items[indexPath.row]

        var content = cell.defaultContentConfiguration()
        content.text = item.title
        content.image = UIImage(named: item.imageName)
        content.imageProperties.maximumSize = CGSize(width: 50, height: 50) // размер иконки
        content.imageProperties.cornerRadius = 8                           // чуть закруглим
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let vc = DetailViewController.instantiate()
        vc.item = items[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
