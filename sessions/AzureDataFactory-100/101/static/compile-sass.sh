# install node-sass if not present on machine
npm list -g | grep node-sass || npm install -g node-sass --no-shrinkwrap

node-sass base.scss base.css
# node-sass njacademy.scss njacademy.css
# node-sass njacademy-pdf.scss njacademy-pdf.css
node-sass external-training.scss external-training.css