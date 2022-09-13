# Create database cinema
DROP DATABASE IF EXISTS cinema;
CREATE DATABASE cinema;
USE cinema;

SET NAMES utf8 ;
SET character_set_client = utf8mb4 ;

# Create tables / relations
DROP TABLE IF EXISTS Customer;
CREATE TABLE Customer (
    cId VARCHAR(11) NOT NULL DEFAULT 0,
    Fname VARCHAR(20) NOT NULL,
    Lname VARCHAR(20) NOT NULL,
    cMail VARCHAR(30) NOT NULL,
    cPassword VARCHAR(20) NOT NULL,
    cAddress VARCHAR(30) NULL,
    cPhone VARCHAR(11) NOT NULL,
    cBirthdate DATE,
    PRIMARY KEY (cId)
);

DROP TABLE IF EXISTS Movie;
CREATE TABLE Movie (
    mId VARCHAR(11) NOT NULL DEFAULT 0,
    mName VARCHAR(50) NOT NULL,
    Release_date DATE,
    Duration INT(10) NOT NULL DEFAULT 0,
    Language VARCHAR(50),
    Country VARCHAR(30),
    Ratings DECIMAL(8,1),
    Description VARCHAR(500),
    M_Director VARCHAR(50),
    PRIMARY KEY (mId)
);

DROP TABLE IF EXISTS Theater;
CREATE TABLE Theater (
    tId VARCHAR(11) NOT NULL DEFAULT 0,
    tName VARCHAR(30),
    tLocation VARCHAR(50) NOT NULL,
    tHallAmt INT(10),
    PRIMARY KEY (tId) 
);

DROP TABLE IF EXISTS Hall;
CREATE TABLE Hall (
    hID VARCHAR(11) NOT NULL DEFAULT 0,
    hSeatAmt INT(10),
    tId VARCHAR(11) NOT NULL,
    PRIMARY KEY (hID, tId),
    FOREIGN KEY (tId) REFERENCES cinema.Theater(tId) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS Seat;
CREATE TABLE Seat (
    sId VARCHAR(11) NOT NULL DEFAULT 0,
    Status TINYINT(2),
    hId VARCHAR(11) NOT NULL,
    tID VARCHAR(11) NOT NULL,
    PRIMARY KEY (sId, hId, tId),
    FOREIGN KEY (hId, tId) REFERENCES cinema.Hall(hId, tId) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS MovieShow;
CREATE TABLE MovieShow (
    shId VARCHAR(11) NOT NULL DEFAULT 0,
    Date DATE,
    Start TIME,
    End TIME,
    mId VARCHAR(11) NOT NULL,
    hId VARCHAR(11) NOT NULL,
    tID VARCHAR(11) NOT NULL,
    PRIMARY KEY (shId),
    FOREIGN KEY (hId, tId) REFERENCES cinema.Hall(hId, tId) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (mId) REFERENCES cinema.Movie(mId) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS Payment;
CREATE TABLE Payment (
    pId VARCHAR(11) NOT NULL,
    ticketNo INT(2),
    Price DECIMAL(9, 2),
    Amount DECIMAL(9, 2) GENERATED ALWAYS AS (ticketNo * Price),
    Method VARCHAR(10),
    PRIMARY KEY (pId)
);

DROP TABLE IF EXISTS BookingTicket;
CREATE TABLE BookingTicket (
    ticketId VARCHAR(11) NOT NULL DEFAULT 0,
    Booking_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    cId VARCHAR(11) NOT NULL,
    shId VARCHAR(11) NOT NULL,
    sId VARCHAR(11) NOT NULL,
    tId VARCHAR(11) NOT NULL,
    hID VARCHAR(11) NOT NULL,
    pId VARCHAR(11) NOT NULL,
    PRIMARY KEY (ticketId),
    FOREIGN KEY (cId) REFERENCES cinema.Customer(cId) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (shId) REFERENCES cinema.MovieShow(shId) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (sId, hId, tId) REFERENCES cinema.Seat(sId, hId, tId) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (pId) REFERENCES cinema.Payment(pId) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS MovieGenre;
CREATE TABLE MovieGenre (
    mId VARCHAR(11) NOT NULL,
    mGenre VARCHAR(20),
    PRIMARY KEY (mId, mGenre),
    FOREIGN KEY (mId) REFERENCES cinema.Movie(mId) ON DELETE CASCADE ON UPDATE CASCADE
);


# Insert data
INSERT INTO cinema.Customer 
	VALUES ('037546', 'Nguyen', 'Ba Cuong', 'cuong24@gmail.com', 'thisiscuong', '24 Wayne Street', '0937123637', '2001-06-13'),
			('0762896', 'Tran', 'Ba Van', 'vantran@gmail.com', 'van123', '16/9 Nguyen Dinh Chieu', '0705060030', '2005-01-12'),
			('028466', 'Ton', 'Vu Anh Thu', 'anhthuton12@gmail.com', 'thu2912', '333/12 Le Van Sy', '0691357288', '2000-12-12'),
			('167890', 'Dang', 'Van Ngu', 'ngutheclawn@gmail.com', 'dangvanngu', '188 Tran Van Quang-Tan Binh', '0905974992', '1992-03-20'),
			('109102', 'Do', 'Thi Ngoc Ngan', 'ngocngando266@gmail.com', 'cobengocngech', '14 Vo Nguyen Giap- Hoai Huong', '0902666885', '2002-06-26'),
			('267098', 'Vo', 'Le Thuan Thao', 'thaovole41@gmail.com', 'thaolevo123', '23 Le Anh Xuan - Hoai Hai', '0372984445', '2004-04-01'),
			('217136', 'Tran', 'Bao Duy', 'duytranbao@student.hcmiu.edu', 'tranbaoduy', '12/3 Dien Bien Phu - Q1', '034589112', '2002-08-20'),
			('201006', 'Nguyen', 'Phi Khanh', 'nguyenphikhanh02@gmail.com', 'khanhtheclawn', '333/16/2 Le Van Sy', '0868546202', '2002-04-19'),
			('234123', 'Le',  'Ngoc Uyen Phuong', 'uyenphuongle224@gmail.com', 'upsort224', '55G Tran Van Quang', '0775900187', '2002-04-12'),
			('378904', 'Dang', 'Chi Thinh', 'thinhdangchi@gmail.com', 'thinhkhung', '21 Di An Binh Duong', '0935357102', '2002-08-07');

INSERT INTO cinema.Movie 
	VALUES ('001', 'DOCTOR STRANGE IN THE MULTIVERSE OF MADNESS', '2022-05-06', 126, 'English', 'United States', 7.5, 'Dr. Stephen Strange casts a forbidden spell that opens the door to the multiverse, including an alternate version of himself, whose threat to humanity is too great for the combined forces of Strange, Wong, and Wanda Maximoff.', 'Sam Raimi'),
			('002', 'EXTREMELY EASY JOB', '2022-04-29', 113, 'Vietnamese', 'Vietnam', 5.1, ' ', 'Võ Thanh Hòa'),
			('003', 'FAST & FEEL LOVE', '2022-04-06', 131, 'Thai', 'Thailand', 7.4, 'When a world champion of sport stacking is dumped by his long-time girlfriend, he has to learn basic adulting skills in order to live alone and take care of himself.', 'Nawapol Thamrongrattanarit'),
			('004', 'JUJUTSU KAISEN 0: THE MOVIE', '2022-03-18', 105, 'Japanese', 'Japan', 7.9, 'Yuta Okkotsu, a high schooler who gains control of an extremely powerful Cursed Spirit and gets enrolled in the Tokyo Prefectural Jujutsu High School by Jujutsu Sorcerers to help him control his power and keep an eye on him.', 'Seong-Hu Park'),
			('005', 'FANTASTIC BEASTS: THE SECRETS OF DUMBLEDORE', '2022-04-15', 143, 'English', 'United Kingdom', 6.5, 'Professor Albus Dumbledore knows the powerful Dark wizard Gellert Grindelwald is moving to seize control of the wizarding world. Unable to stop him alone, he entrusts Magizoologist Newt Scamander to lead an intrepid team of wizards, witches and one brave Muggle baker on a dangerous mission, where they encounter old and new beasts and clash with Grindelwald\'s growing legion of followers.', 'David Yates'),
			('006', 'PEE NAK 3', '2022-04-15', 110, 'Thai', 'Thailand', 6.1, 'The Karma team attended Aod\'s ordination ceremony but had to be postponed due to the appearance of a curse from the anklet. Min Jun, Balloon, First must race against time to find a way to break the curse before the devil comes to take Aod\'s life.', 'Phontharis Chotkijsadarsopon'),
			('007', 'MIDNIGHT', '2022-04-15', 103, 'Korean', 'Korea', 6.5, 'Kyung-mi, a girl with hearing impairment lives with her mother. Working at the customer call center, one day she storms out of an unpleasant dinner with the client and drives home after she picks up her mother. Meanwhile, the murderer Do-sik spots Kyung-mi\'s mother waiting for her daughter who went to park her car but changes his target when another girl So-jung passes him by talking on the phone.', 'Kwon Oh-seung'),
			('008', 'THE BAD GUYS', '2022-04-22', 100, 'English', 'United States', 6.9, 'Several reformed yet misunderstood criminal animals attempt to become good, with some disastrous results along the way.', 'Pierre Perifel');
            
INSERT INTO cinema.MovieGenre 
	VALUES ('001', 'Action'),
			('001', 'Adventure'),
            ('001', 'Fantasy'),
            ('002', 'Action'),
            ('002', 'Comedy'),
            ('003', 'Comedy'),
            ('003', 'Romance'),
            ('004', 'Animation'),
            ('004', 'Fantasy'),
            ('005', 'Adventure'),
            ('005', 'Fantasy'),
            ('006', 'Horror'),
            ('007', 'Thriller'),
            ('008', 'Animation'),
            ('008', 'Comedy');
            
INSERT INTO cinema.Theater 
	VALUES ('097387', 'Tran Quang Dieu', '14 Tran Quang Dieu P11 Tan Binh', 6),
			('086775', 'New Galaxy', '5 Nguyen Cong Hoan P7 Phu Nhuan', 6),
			('167345', 'Banh Van Tran', '23/4 Mac Dinh Chi p1 Tan Phu', 4),
			('156982', 'The Old Theater', ' 9 Le Van Sy P1 Tan Binh', 4),
			('036135', 'SuperStar', '188 Nguyen Thi Minh Khai Q1', 4);
            
INSERT INTO cinema.Hall 
	VALUES ('G11', 60,'097387'),
			('G12', 60, '097387'),
			('G13', 70, '097387'),
			('D11', 50, '097387'),
			('G14', 60, '097387'),
			('D12', 40, '097387'),
			('D11', 40, '086775'),
			('G11', 70, '086775'),
			('G12', 60, '086775'),
			('G11', 70, '167345'),
			('D11', 50, '167345'),
			('D11', 50, '156982'),
			('G11', 70, '156982'),
			('D11', 50, '036135'),
			('G11', 60, '036135'),
			('D12', 40, '036135');

INSERT INTO cinema.MovieShow 
	VALUES ('MS001', '2022-05-11', '15:00', '17:06', '001', 'G11', '097387'),
			('MS002', '2022-05-11', '20:00', '22:06', '001', 'G12', '097387'),
			('MS003', '2022-05-12', '16:00', '17:53', '002', 'G13', '097387'),
			('MS004', '2022-05-12', '22:00', '23:53', '002', 'D11', '097387'),
			('MS005', '2022-05-14', '14:00', '16:11', '003', 'G14', '097387'),
			('MS006', '2022-05-20', '16:00', '17:45', '004', 'D12', '097387'),
			('MS007', '2022-05-21', '12:00', '14:23', '005', 'G12', '086775'),
			('MS008', '2022-06-01', '14:00', '16:23', '005', 'G11', '167345'),
			('MS009', '2022-06-02', '20:00', '21:50', '006', 'D11', '156982'),
			('MS010', '2022-06-05', '17:00', '18:43', '007', 'G11', '036135'),
			('MS011', '2022-06-07', '18:00', '19:40', '008', 'D12', '036135');
            
INSERT INTO cinema.Seat 
	VALUES  ('B2', 0, 'D11','097387'),
            ('B5', 0, 'D11','097387'),
            ('B9', 1, 'D11','097387'),
            ('C5', 1, 'D12','097387'),
            ('C6', 0, 'D12','097387'),
            ('B5', 1, 'G11','097387'),
            ('F3', 0, 'G11','097387'),
			('C9', 1, 'G12','097387'),
            ('C8', 0, 'G12','097387'),
            ('G1', 0, 'G13','097387'),
            ('A6', 0, 'D12','036135'),
            ('D7', 0, 'G11','036135'),
            ('D4', 0, 'G11','036135'),
            ('E4', 1, 'G11','156982'),
            ('E7', 1, 'G11','156982'),
            ('C5', 0, 'G12','086775'),
            ('F6', 0, 'G11','086775'),
            ('D3', 0, 'D11','167345'),
		    ('A10', 0, 'G11','167345'),
            ('G4', 0, 'G11','167345');
            
INSERT INTO cinema.Payment (pId, ticketNo, Price, Method)
	VALUES ('PM01', 1, 50000, 'MasterCard'),
			('PM02', 2, 50000, 'Visa'),
			('PM03', 2, 50000, 'PayPal'),
			('PM04', 1, 50000, 'MasterCard'),
			('PM05', 1, 50000, 'Visa'),
            ('PM06', 3, 50000, 'Paypal');
            
INSERT INTO cinema.BookingTicket 
	VALUES ('A1005B5', '2022-05-10 12:00:00', '037546','MS001', 'B5', '097387', 'G11', 'PM01'),
			('A0905C8', '2022-05-09 11:28:00', '0762896', 'MS002', 'C8', '097387', 'G12', 'PM02'),
			('A0905C9', '2022-05-09 11:28:00', '0762896','MS002', 'C9', '097387', 'G12', 'PM02'),
			('D1105E4', '2022-05-11 08:55:00', '167890', 'MS003', 'E4', '156982', 'G11', 'PM03'),
			('D1005E7', '2022-05-10 08:55:00', '167890', 'MS003', 'E7', '156982', 'G11', 'PM03'),
			('A1305B9', '2022-05-13 07:00:00', '267098', 'MS005', 'B9', '097387', 'D11', 'PM04'),
			('A1905C5', '2022-05-19 08:23:00', '217136', 'MS006', 'C5', '097387', 'D12', 'PM05'),
			('B2005C5', '2022-05-20 09:30:00', '201006', 'MS007', 'C5', '086775','G12', 'PM06');    