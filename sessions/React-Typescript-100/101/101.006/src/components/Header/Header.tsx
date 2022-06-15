import React from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faEarth } from '@fortawesome/free-solid-svg-icons';

function Header() {
  return (
    <div style={{
      display: 'flex',
      justifyContent: 'center',
      alignItems: 'center',
      color: '#fff',
      backgroundColor: '#005985',
      padding: '24px 12px',
    }}
    >
      <FontAwesomeIcon icon={faEarth} size="2x" />
      <h1 style={{ marginLeft: '12px' }}>How is the weather?</h1>
    </div>
  );
}

export default Header;
