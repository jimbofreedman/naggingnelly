import React from 'react';
import ReactDOM from 'react-dom';
import MomentUtils from '@date-io/moment';

import './index.css';
import App from './App';
import * as serviceWorker from './serviceWorker';
import * as Sentry from '@sentry/browser';
import config from "./config";
import {MuiPickersUtilsProvider} from "@material-ui/pickers";

if (config.sentryDSN) {
    Sentry.init({ dsn: config.sentryDSN });
}

ReactDOM.render(
    <React.StrictMode>
        <MuiPickersUtilsProvider utils={MomentUtils}>
            <App />
        </MuiPickersUtilsProvider>
    </React.StrictMode>,
    document.getElementById('root'),
);

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
