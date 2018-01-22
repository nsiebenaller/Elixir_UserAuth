// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
import {Socket, Presence} from "phoenix"
import socket from "./socket";

function renderOnlineUsers(presences) {
  let response = "";

  let count = 0;
  Presence.list(presences, (id, {metas: [first, ...rest]}) => {
    count = rest.length + 1
    response += `<li>${id}</li>`
  });

  let numUsers = `<div>number of users: ${count}</div>`;
  document.querySelector("#number-users").innerHTML = numUsers;
  document.querySelector("#user-list").innerHTML = response;
}

let presences = {}

let channel = socket.channel("room:lobby", {})

channel.on("presence_state", state => {
  console.log('presence state run');
  presences = Presence.syncState(presences, state)
  renderOnlineUsers(presences)
})

channel.on("presence_diff", diff => {
  console.log('presence diff run');
  presences = Presence.syncDiff(presences, diff)
  renderOnlineUsers(presences)
})
channel.on("new:msg", message => {renderMessage(message)});

channel.join()


let formatTimestamp = (timestamp) => {

  let date = new Date(timestamp);
  console.log(date);
  return date.toLocaleTimeString();
}

let messageInput = document.getElementById("new-message");
messageInput.addEventListener("keypress", (e) => {
  if(e.keyCode == 13 && messageInput.value != "") {
    channel.push("new:msg", {user: username, body: messageInput.value});
    messageInput.value = "";
  }
});

let messageList = document.getElementById("message-list");
let renderMessage = (message) => {

  let messageEle = document.createElement("li");
  messageEle.innerHTML = `<b>${message.user}</b>
  <i>${formatTimestamp(message.timestamp)}</i>
  <p>${message.body}</p>`;

  messageList.appendChild(messageEle);
  messageList.scrollTop = messageList.scrollHeight;
}


let urlToParse = location.search;  
let result = parseQueryString(urlToParse );  
let username = result['name'];
console.info(username + ' logged in');  

function parseQueryString(url) {
  let urlParams = {};
  url.replace(
    new RegExp("([^?=&]+)(=([^&]*))?", "g"),
    function($0, $1, $2, $3) {
      urlParams[$1] = $3;
    }
  );
  
  return urlParams;
}

