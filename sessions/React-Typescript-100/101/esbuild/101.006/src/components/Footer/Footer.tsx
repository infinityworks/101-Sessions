import React from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faFacebook, faTwitter } from '@fortawesome/free-brands-svg-icons';

function Footer() {
  return (
    <div style={{ backgroundColor: '#3B3B3B', padding: '24px 12px', color: '#fff' }}>
      <div style={{ display: 'flex', justifyContent: 'center' }}>
        <a href="www.facebook.com" target="_blank" aria-label="facebook" style={{ marginRight: '12px' }}>
          <FontAwesomeIcon icon={faFacebook} size="2x" color="#fff" />
        </a>
        <a href="www.twitter.com" target="_blank" aria-label="twitter">
          <FontAwesomeIcon icon={faTwitter} size="2x" color="#fff" />
        </a>
      </div>
      <p style={{ padding: '12px' }}>
        A seven-day forecast can accurately predict the weather about 80 percent of the time
        and a five-day forecast can accurately predict the weather approximately 90 percent
        of the time. However, a 10-day or longer forecast is only right about half the time.
      </p>
    </div>
  );
}

export default Footer;
