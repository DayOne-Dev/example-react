import logo from './logo.svg';
import Clock from "./Clock";
import './App.css';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://DayOne.dev"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
        <Clock />
      </header>
    </div>
  );
}

export default App;
