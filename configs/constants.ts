// Database configuration
export const dbConfig = {
    user: 'wms_ezoua',
    password: 'P@ssw0rd@200',
    // ²server: '10.10.32.12',
    server: '10.10.2.31',
    port: 1433,
    database: 'WMS_MP',
    options: {
        encrypt: false,
        trustServerCertificate: true
    }
};

// Notification endpoint
// export const NOTIFICATION_URL = 'http://10.10.32.2:3030/notifications';
//export const NOTIFICATION_URL = 'http://10.10.2.117:3030/notifications';
// export const TIMEOUT_SETTING = 20; //in minutes 1 ,heure 60