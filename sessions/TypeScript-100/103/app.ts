import express, { Application } from 'express';

import path from 'path';
import cookieParser from 'cookie-parser';
import morgan from 'morgan';

import indexRouter from './routes/index';
import usersRouter from './routes/users';

const app: Application = express();

app.use(morgan('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/users', usersRouter);

module.exports = app;
