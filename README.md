# Bears-Nation-App
Turning the washubears.com website into an app

## Features

### Home
The home tab lists the 30 most recent articles on the WashU Bears website. Clicking on each article will direct the user to a detailed view for the article, with the article title, image, and the content.

### Teams
The teams tab lists all the WashU sports teams. Clicking on a team will direct the user to a page with the team's roster and their schedule. Clicking on a player's name will reveal the player's stats/bio. Clicking on a game will direct the user to a view with more information about the game. The user can also change the year by tapping the year in the top right corner. 

### Schedule
The schedule tab lists all the WashU athletics games for a certain date. The user can click any of the listed dates above (which consist of the current date and the following three dates) to get a list of all the games for that date. The user can also select the calendar icon on the top right, which will reveal a date picker that allows the user to pick any date they want. 
The main schedule page displays the team name, the status, the score, the opponent, and the opponents logo. Clicking on a game will direct the user to a detailed view that shows results/recap/live highlights (if they exist).

### Message
The message tab allows users to interact with the WashU athletics community.Users can create a new post by clicking the "New Post" button on the top right. Users can input a username, a subject, and a message to post. The submitted messages are displayed on the main message board, and clicking on a message will reveal the comments for that message. Users can comment by clicking the "New Comment" button ont the top right and inputting the username and the reply to post. Users can also sort the comments by oldest first by clicking the switch.

### More
There are four main views on the More tab: WashU Bears Shop, Gameday, Inside Athletics, and Letter from the A.D.
The WashU Bears Shop displays the WashU shop, where users can buy WashU athletics gear. The gameday view has pages that holds information about tailgating, ticketing, the visitor's guide, and the WashU Sports Network. The Inside Athletics view has pages that inform the user about its mission, directory, facilities, history and SAAC. The Letter from the A.D. view displays a message from the athletic directory for the WashU Bears community.




All the information was scraped from the WashU Bears Website using python. We used express.js and MongoDB to create the api to access the information.
