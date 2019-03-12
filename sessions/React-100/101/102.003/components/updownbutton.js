import React from 'react';
import Button from '@material-ui/core/Button';

export default ({ label, onClick, disabled }) => (
  <Button variant="contained" color="primary" onClick={onClick} disabled={disabled}>{label}</Button>
);
