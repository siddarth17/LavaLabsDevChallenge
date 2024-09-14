import React, { useState, useEffect } from 'react';
import Menu from './components/Menu';
import Content from './components/Content';
import './App.css';

function App() {
  // Retrieve documents from localStorage or initialize with default data
  const getInitialDocuments = () => {
    const savedDocuments = localStorage.getItem('documents');
    return savedDocuments ? JSON.parse(savedDocuments) : [
      { title: "Assignment 1", timeAgo: "1m ago", type: "Your Projects", originalType: "Your Projects" },
      { title: "Lab 3", timeAgo: "40m ago", type: "Shared with You", originalType: "Shared with You" },
      { title: "Workbook Ch. 3", timeAgo: "2 hrs ago", type: "Your Projects", originalType: "Your Projects" },
      { title: "Worksheet 2", timeAgo: "Apr 25, 2024", type: "Shared with You", originalType: "Shared with You" },
      { title: "Resume", timeAgo: "March 27, 2023", type: "Shared with You", originalType: "Shared with You" },
      { title: "Assignment 3", timeAgo: "Feb 20, 2023", type: "Shared with You", originalType: "Shared with You" },
    ];
  };

  const [documents, setDocuments] = useState(getInitialDocuments);
  const [activePage, setActivePage] = useState('All Projects');
  const [selectedDocument, setSelectedDocument] = useState(null);

  // Save documents to localStorage whenever they change
  useEffect(() => {
    localStorage.setItem('documents', JSON.stringify(documents));
  }, [documents]);

  const addNewDocument = (newDoc) => {
    const updatedDocuments = [...documents, { title: newDoc.name, timeAgo: "Just Now", type: newDoc.type, originalType: newDoc.type }];
    setDocuments(updatedDocuments);
    localStorage.setItem('documents', JSON.stringify(updatedDocuments));  // Save to localStorage
  };

  const handleMenuClick = (page) => {
    setActivePage(page);
  };

  const handleMoveDocument = (title, target) => {
    const updatedDocuments = documents.map(doc =>
      doc.title === title ? { ...doc, type: target } : doc
    );
    setDocuments(updatedDocuments);
    localStorage.setItem('documents', JSON.stringify(updatedDocuments));  // Save to localStorage
    setSelectedDocument(null); 
  };

  const handleRestoreDocument = (title) => {
    const updatedDocuments = documents.map(doc =>
      doc.title === title ? { ...doc, type: doc.originalType } : doc
    );
    setDocuments(updatedDocuments);
    localStorage.setItem('documents', JSON.stringify(updatedDocuments));  // Save to localStorage
    setSelectedDocument(null); 
  };

  const filteredDocuments = documents.filter(doc => {
    if (activePage === 'All Projects') {
      return doc.type !== 'Trash' && doc.type !== 'Archived';
    }
    return doc.type === activePage;
  });

  return (
    <div className="app">
      <Menu addNewDocument={addNewDocument} onMenuClick={handleMenuClick} />
      <Content
        documents={filteredDocuments}
        activePage={activePage}
        setSelectedDocument={setSelectedDocument}
      />

      {}
      {selectedDocument && (
        <div className="document-popup">
          <div className="popup-content">
            <button className="button-close" onClick={() => setSelectedDocument(null)}>&times;</button>
            <h3>{selectedDocument.title}</h3>

            {activePage === 'Trash' || activePage === 'Archived' ? (
              <button onClick={() => handleRestoreDocument(selectedDocument.title)}>
                Restore
              </button>
            ) : (
              <div className="popup-buttons">
                <button className="button-archive" onClick={() => handleMoveDocument(selectedDocument.title, 'Archived')}>
                  Move to Archive
                </button>
                <button className="button-trash" onClick={() => handleMoveDocument(selectedDocument.title, 'Trash')}>
                  Move to Trash
                </button>
              </div>
            )}
          </div>
        </div>
      )}
    </div>
  );
}

export default App;
