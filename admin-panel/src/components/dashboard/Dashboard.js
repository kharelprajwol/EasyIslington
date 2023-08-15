import React, { useState, useEffect } from 'react';
import './Dashboard.css';

function Dashboard() {
    const [totalStudents, setTotalStudents] = useState(0);
    const [totalPosts, setTotalPosts] = useState(0); 
    

    useEffect(() => {
        // Fetch total students count
        fetch('http://localhost:3000/admin/total-students')
            .then(response => response.json())
            .then(data => setTotalStudents(data.count))
            .catch(error => console.error("Error fetching total students:", error));

    // Fetch total posts count
    fetch('http://localhost:3000/admin/total-posts')
        .then(response => response.json())
        .then(data => setTotalPosts(data.count))
        .catch(error => console.error("Error fetching total posts:", error));
}, []);

    return (
        <div className="dashboard">
            <section>
                <h2>Total Students Count</h2>
                <p>{totalStudents}</p>
            </section>

            <section>  
                <h2>Total Posts Count</h2>
                <p>{totalPosts}</p>
            </section>
        </div>
    );
}

export default Dashboard;
