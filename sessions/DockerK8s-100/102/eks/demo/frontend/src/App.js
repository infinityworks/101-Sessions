import React, { Component } from "react";
import "./App.css";

class App extends Component {
  constructor(props) {
    super(props);

    this.state = {
      attendees: []
    };
  }

  componentDidMount() {
    fetch(`https://101-k8s-api.matthewleak.co.uk/api/attendees`)
      .then(response => response.json())
      .then(data => this.setState({ attendees: data.attendees }));
  }

  render() {
    const { attendees } = this.state;

    return (
      <div className="App">
        <header className="App-header">
          <h1>101 Attendees ({attendees.length})</h1>
        </header>
        <div className="Attendees">
          {attendees.map(attendee => (
            <div className="Attendee">
              <div className="AttendeeImage">
                {attendee.member.hasOwnProperty("photo") ? (
                  <img
                    width="50"
                    height="50"
                    src={attendee.member.photo.thumb_link}
                    alt={attendee.member.name}
                  />
                ) : null}
              </div>
              <div className="AttendeeName">
                <p>{attendee.member.name}</p>
              </div>
            </div>
          ))}
        </div>
      </div>
    );
  }
}

export default App;
