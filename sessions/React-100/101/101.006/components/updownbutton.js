import React from 'react';
import Button from '@material-ui/core/Button';

export default ({ label, action }) => (
  <Button variant="contained" color="primary" onClick={action}>{label}</Button>
);
