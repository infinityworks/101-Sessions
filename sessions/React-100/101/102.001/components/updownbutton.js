import React from 'react';
import Button from '@material-ui/core/Button';

export default ({ label, action, disabled }) => (
  <Button variant="contained" color="primary" onClick={action} disabled={disabled}>{label}</Button>
);
