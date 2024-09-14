import React, { useState } from "react";
import './Content.css';
import searchIcon from '../assets/searchicon.png';
import profilePic from '../assets/profilepic.png';
import sortIcon1 from '../assets/gridview.png';
import sortIcon2 from '../assets/listview.png';
import fileIcon from '../assets/fileicon.png';

const Card = ({ title, timeAgo, isListView, onClick }) => {
  return (
    <div className={`card ${isListView ? 'list-view' : ''}`} onClick={onClick}>
      <div className={`card-image ${isListView ? 'list-view-image' : ''}`}>
        <img src={fileIcon} alt="File Icon" className="file-icon" />
      </div>
      <div className={`card-details ${isListView ? 'list-view-details' : ''}`}>
        <h3 className="card-title">{title}</h3>
        <p className="card-time">{timeAgo}</p>
      </div>
    </div>
  );
};

function Content({ documents, activePage, setSelectedDocument }) {
  const [selectedIcon, setSelectedIcon] = useState('icon1');
  const [searchQuery, setSearchQuery] = useState('');
  const [showDropdown, setShowDropdown] = useState(false); // Add state to toggle dropdown

  const filteredDocuments = documents.filter(doc =>
    doc.title.toLowerCase().includes(searchQuery.toLowerCase())
  );

  const isListView = selectedIcon === 'icon2';

  return (
    <div className="content">
      <div className="search-profile-wrapper">
        <div className="search-bar">
          <img src={searchIcon} alt="Search Icon" className="search-icon" />
          <input 
            type="text" 
            className="search-input" 
            placeholder={`Search in Aro`} 
            value={searchQuery} 
            onChange={(e) => setSearchQuery(e.target.value)}
          />
        </div>

        <div className="profile-button" onClick={() => setShowDropdown(!showDropdown)}>
          <img src={profilePic} alt="Profile" className="profile-pic" />
          <div className="profile-info">
            <span className="profile-name">Cole Gawin</span>
            <span className="profile-email">colegawin@gmail.com</span>
          </div>

          {/* Dropdown for Account Details and Logout */}
          {showDropdown && (
            <div className="profile-dropdown">
              <ul>
                <li onClick={() => alert('Account Details Clicked')}>Account Details</li>
                <li onClick={() => alert('Logout Clicked')}>Logout</li>
              </ul>
            </div>
          )}
        </div>
      </div>

      <hr className="separator" />

      <div className="projects-header">
        <div className="projects-title">{activePage}</div>
        <div className="sorting-icons">
          <img
            src={sortIcon1}
            alt="Sort Icon 1"
            className={`sort-icon ${selectedIcon === 'icon1' ? 'active-icon' : ''}`}  
            onClick={() => setSelectedIcon('icon1')}
          />
          <img
            src={sortIcon2}
            alt="Sort Icon 2"
            className={`sort-icon smaller-icon ${selectedIcon === 'icon2' ? 'active-icon' : ''}`}  
            onClick={() => setSelectedIcon('icon2')}
          />
        </div>
      </div>

      <div className={`card-row ${isListView ? 'list-view-row' : ''}`}>
        {filteredDocuments.map((doc, index) => (
          <Card
            key={index}
            title={doc.title}
            timeAgo={doc.timeAgo}
            isListView={isListView}
            onClick={() => setSelectedDocument(doc)}
          />
        ))}
      </div>
    </div>
  );
}

export default Content;
