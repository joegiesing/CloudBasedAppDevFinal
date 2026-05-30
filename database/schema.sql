CREATE DATABASE IF NOT EXISTS openstandard;
USE openstandard;

CREATE TABLE User (
    user_ID     INT AUTO_INCREMENT PRIMARY KEY,
    User_First  NVARCHAR(100) NOT NULL,
    User_Last   NVARCHAR(100) NOT NULL,
    Email       NVARCHAR(255) NOT NULL UNIQUE,
    Password    NVARCHAR(255) NOT NULL,
    Is_Admin    BOOLEAN DEFAULT FALSE,
    Date_joined DATETIME DEFAULT NOW(),
    Is_Active   BOOLEAN DEFAULT TRUE
);

CREATE TABLE Portfolio (
    Portfolio_ID   INT AUTO_INCREMENT PRIMARY KEY,
    User_ID        INT NOT NULL,
    Portfolio_Name NVARCHAR(255),
    FOREIGN KEY (User_ID) REFERENCES User(user_ID)
);

CREATE TABLE Asset_Information (
    Asset_ID INT AUTO_INCREMENT PRIMARY KEY,
    Ticker   NVARCHAR(20) NOT NULL,
    Name     NVARCHAR(255) NOT NULL,
    Type     VARCHAR(50) NOT NULL
);

CREATE TABLE Transaction (
    Transaction_ID INT AUTO_INCREMENT PRIMARY KEY,
    Portfolio_ID   INT NOT NULL,
    Asset_ID       INT NOT NULL,
    Quantity       INT NOT NULL,
    Date           DATETIME DEFAULT NOW(),
    Price          FLOAT NOT NULL,
    Type           VARCHAR(50) NOT NULL,
    FOREIGN KEY (Portfolio_ID) REFERENCES Portfolio(Portfolio_ID),
    FOREIGN KEY (Asset_ID) REFERENCES Asset_Information(Asset_ID)
);

CREATE TABLE Price_History (
    History_ID INT AUTO_INCREMENT PRIMARY KEY,
    Asset_ID   INT NOT NULL,
    Day_Price  FLOAT NOT NULL,
    Date       DATETIME DEFAULT NOW(),
    FOREIGN KEY (Asset_ID) REFERENCES Asset_Information(Asset_ID)
);

CREATE TABLE Bonds_Information (
    Bond_ID       INT AUTO_INCREMENT PRIMARY KEY,
    Asset_ID      INT NOT NULL,
    Int_Price     FLOAT NOT NULL,
    EXP_Date      DATETIME NOT NULL,
    Interest_Rate FLOAT NOT NULL,
    FOREIGN KEY (Asset_ID) REFERENCES Asset_Information(Asset_ID)
);