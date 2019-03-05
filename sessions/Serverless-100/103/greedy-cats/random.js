const getRandomIndex = (maximum, avoid) => {
    if (maximum <= 1) {
        return 0;
    }
    let r = Math.floor(Math.random()*(maximum-1));
    if (r >= avoid) {
        return r+1;
    }
    return r;
};

module.exports = { getRandomIndex };