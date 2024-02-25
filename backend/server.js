

const express = require('express');
const axios = require('axios');

const app = express();
const PORT = process.env.PORT || 3000;
const CLIENT_ID = '42HMMDVZW21BT4HT00CDTJF3MKJRYWMPWKDKS1DZN3WKFHD2';
const CLIENT_SECRET = 'P0DRNHGWLMAOQMON0KWXWBWLGXVYJXCG4IZ12GJDPATD3CK4';
const VERSION = '20230224'; // Use the current date in YYYYMMDD format


function formatFoursquareData(results) {
    return results.map(place => {
        return {
            name: place.name,
            address: place.location.formatted_address,
            open_status: interpretOpenStatus(place.closed_bucket), // Custom function to interpret open status
            phone_number: place.contact?.phone || 'Phone number not available' // Assuming 'contact' field exists
        };
    });
}

function interpretOpenStatus(closedBucket) {
    switch (closedBucket) {
        case 'VeryLikelyOpen':
            return 'Open';
        case 'LikelyOpen':
            return 'Probably Open';
        case 'Unsure':
            return 'Open Status Uncertain';
        // Add more cases as needed based on Foursquare's documentation
        default:
            return 'Open Status Unknown';
    }
}

app.get('/api/hospitals/nearby', async (req, res) => {
    try {
       // const { latitude, longitude } = req.query;
       const latitude = 33.87029; 
       const longitude = -117.92534;
        if (!latitude || !longitude) {
            return res.status(400).json({ error: 'Latitude and longitude are required' });
        }

        const url = `https://api.foursquare.com/v2/venues/search?client_id=${CLIENT_ID}&client_secret=${CLIENT_SECRET}&v=${VERSION}&ll=${latitude},${longitude}&query=hospital&intent=browse&radius=10000`; // radius in meters

        const foursquareResponse = await axios.get(url);
        const hospitals = foursquareResponse.data.response.venues.map(venue => ({
            name: venue.name,
            location: venue.location
        }));

        res.json({ hospitals });
    } catch (error) {
        console.error('Error:', error.message);
        if (error.response) {
            // The request was made and the server responded with a status code
            // that falls out of the range of 2xx
            console.error('API response error:', error.response.data);
            res.status(error.response.status).json({ error: error.response.data });
        } else if (error.request) {
            // The request was made but no response was received
            console.error('API no response error:', error.request);
            res.status(500).json({ error: 'No response from server' });
        } else {
            // Something happened in setting up the request that triggered an Error
            console.error('API setup error:', error.message);
            res.status(500).json({ error: 'Error setting up API request' });
        }
    }
});

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});

async function placeSearch(latitude, longitude) {
    try {
        const searchParams = new URLSearchParams({
            query: 'hospital',
            ll: `${latitude},${longitude}`,
            sort: 'DISTANCE',
            radius:'100000'
        });

        const results = await fetch(
            `https://api.foursquare.com/v3/places/search?${searchParams}`,
            {
                method: 'GET',
                headers: {
                    Accept: 'application/json',
                    Authorization: 'fsq3Xez9snmSagKNVPEreoskNrNKqjnAnOuHQXmch/Al04U=' // Replace with your actual token
                }
            }
        );

        const data = await results.json();
        
    return formatFoursquareData(data.results);
    } catch (err) {
        console.error(err);
        throw err; // Re-throw the error for handling in the Express route
    }
}

app.get('/api/hospitals/nearby2', async (req, res) => {
    try {
       // const { latitude, longitude } = req.query;
        const latitude = 33.87029; 
        const longitude = -117.92534;
        if (!latitude || !longitude) {
            return res.status(400).json({ error: 'Latitude and longitude are required' });
        }

        const data = await placeSearch(latitude, longitude);
        
        res.json(data);
    } catch (error) {
        console.error('Error in API:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});


//fsq3dKVDM9bTEpA9lumpgGeuoU7y2cn9Iy2RYsgO5pq1grk=
