import React, { useState } from "react";
import Modal from 'react-modal'; 
import './Menu.css';
import aroLogo from '../assets/aro-logo.png'; 
import allProjectsIcon from '../assets/allprojects.png';
import yourProjectsIcon from '../assets/yourprojects.png';
import sharedWithYouIcon from '../assets/sharedwithyou.png';
import archivedIcon from '../assets/archived.png';
import trashIcon from '../assets/trash.png';

Modal.setAppElement('#root');

function Menu({ onMenuClick, addNewDocument }) {
  const [activePage, setActivePage] = useState('All Projects'); // Setting initial page as All Projects
  const [isModalOpen, setIsModalOpen] = useState(false); 
  const [newDocument, setNewDocument] = useState({ name: '', type: 'Your Projects' }); 

  const handleNewDocumentSubmit = () => {
    if (newDocument.name.trim()) {
      addNewDocument(newDocument);
      setIsModalOpen(false);  
      setNewDocument({ name: '', type: 'Your Projects' });  
    }
  };

  const handleMenuClick = (page) => {
    setActivePage(page);
    onMenuClick(page);  // Notify parent component (App.js)
  };

  return (
    <div className="menu">
      <img src={aroLogo} alt="Aro Logo" className="menu-logo" />

      <ul>
        <li
          className={activePage === 'All Projects' ? 'active' : ''}
          onClick={() => handleMenuClick('All Projects')}
        >
          <img src={allProjectsIcon} alt="All Projects" className="menu-icon" />
          <span>All Projects</span>
        </li>
        <li
          className={activePage === 'Your Projects' ? 'active' : ''}
          onClick={() => handleMenuClick('Your Projects')}
        >
          <img src={yourProjectsIcon} alt="Your Projects" className="menu-icon" />
          <span>Your Projects</span>
        </li>
        <li
          className={activePage === 'Shared with You' ? 'active' : ''}
          onClick={() => handleMenuClick('Shared with You')}
        >
          <img src={sharedWithYouIcon} alt="Shared with You" className="menu-icon" />
          <span>Shared with You</span>
        </li>
        <li
          className={activePage === 'Archived' ? 'active' : ''}
          onClick={() => handleMenuClick('Archived')}
        >
          <img src={archivedIcon} alt="Archived" className="menu-icon" />
          <span>Archived</span>
        </li>
        <li
          className={activePage === 'Trash' ? 'active' : ''}
          onClick={() => handleMenuClick('Trash')}
        >
          <img src={trashIcon} alt="Trash" className="menu-icon" />
          <span>Trash</span>
        </li>
      </ul>

      <button className="new-button" onClick={() => setIsModalOpen(true)}>
        <span>+</span>
        <span>New</span>
      </button>

      {/* Modal for adding a new document */}
      <Modal
        isOpen={isModalOpen}
        onRequestClose={() => setIsModalOpen(false)}
        contentLabel="Add New Document"
        className="modal"
        overlayClassName="modal-overlay"
      >
        <h2>Add New Document</h2>
        <label>Document Name</label>
        <input 
          type="text" 
          value={newDocument.name} 
          onChange={(e) => setNewDocument({ ...newDocument, name: e.target.value })}
        />
        <label>Type</label>
        <select 
          value={newDocument.type} 
          onChange={(e) => setNewDocument({ ...newDocument, type: e.target.value })}
        >
          <option value="Your Projects">Your Projects</option>
          <option value="Shared with You">Shared with You</option>
        </select>
        <div className="modal-buttons">
          <button onClick={handleNewDocumentSubmit}>Add</button>
          <button onClick={() => setIsModalOpen(false)}>Cancel</button>
        </div>
      </Modal>
    </div>
  );
}

export default Menu;
