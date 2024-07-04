CREATE TABLE `rewards` (
  `index` int(11) NOT NULL,
  `code` char(100) NOT NULL,
  `rewards` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`rewards`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


ALTER TABLE `rewards`
  ADD PRIMARY KEY (`index`);

ALTER TABLE `rewards`
  MODIFY `index` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

