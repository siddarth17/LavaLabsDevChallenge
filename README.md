# LavaLabsDevChallenge

For the development challenge, I have built both a website using React.js, HTML, and CSS, and an iOS app with SwiftUI. The functionalities include adding documents and accessing the "Your Projects," "Shared with You," "Archived," and "Trash" pages. Users can also search for documents and sort them in either grid or list format.

Additionally, documents can be archived or deleted, which moves them to the "Archived" or "Trash" pages, respectively, with the option to restore them to their original status. The "Shared with You" and "Your Projects" pages display the correct documents, and when creating a new document, you can specify whether it is shared or your own, ensuring it appears in the appropriate section.

I used localStorage to ensure that data persists across sessions. This allows users to access their documents, projects, and any modifications (such as moving items to 'Archived' or 'Trash') even after refreshing or reopening the browser. Similarly, in the iOS app, I utilized UserDefaults to store data locally on the device, enabling the app to retain document information between sessions. 
