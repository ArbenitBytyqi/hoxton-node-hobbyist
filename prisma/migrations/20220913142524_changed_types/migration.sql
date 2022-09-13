/*
  Warnings:

  - You are about to drop the `Hobby` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_HobbyToUser` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Hobby";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "User";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "_HobbyToUser";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "Users" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "fullName" TEXT NOT NULL,
    "photo" TEXT,
    "email" TEXT
);

-- CreateTable
CREATE TABLE "Hobbies" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "photo" TEXT,
    "active" BOOLEAN DEFAULT true
);

-- CreateTable
CREATE TABLE "_HobbiesToUsers" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    CONSTRAINT "_HobbiesToUsers_A_fkey" FOREIGN KEY ("A") REFERENCES "Hobbies" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_HobbiesToUsers_B_fkey" FOREIGN KEY ("B") REFERENCES "Users" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "Users_fullName_key" ON "Users"("fullName");

-- CreateIndex
CREATE UNIQUE INDEX "Hobbies_name_key" ON "Hobbies"("name");

-- CreateIndex
CREATE UNIQUE INDEX "_HobbiesToUsers_AB_unique" ON "_HobbiesToUsers"("A", "B");

-- CreateIndex
CREATE INDEX "_HobbiesToUsers_B_index" ON "_HobbiesToUsers"("B");
