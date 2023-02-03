CREATE TABLE `temp_file_chunks` (
  `id` int(11) NOT NULL,
  `file_name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `random` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `start` int(11) NOT NULL,
  `finish` int(11) NOT NULL,
  `size` int(11) NOT NULL,
  `eventTimestamp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `temp_file_chunks`
--
ALTER TABLE `temp_file_chunks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `file_name` (`file_name`),
  ADD KEY `random` (`random`);
