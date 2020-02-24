import React from 'react';

export default ({ label, action }) => (
  <Button onClick={action}>{label}</Button>
);
