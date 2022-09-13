/*
  Warnings:

  - You are about to drop the column `userId` on the `Hobby` table. All the data in the column will be lost.

*/
-- CreateTable
CREATE TABLE "_HobbyToUser" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    CONSTRAINT "_HobbyToUser_A_fkey" FOREIGN KEY ("A") REFERENCES "Hobby" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_HobbyToUser_B_fkey" FOREIGN KEY ("B") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Hobby" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "photo" TEXT,
    "active" BOOLEAN DEFAULT true
);
INSERT INTO "new_Hobby" ("active", "id", "name", "photo") SELECT "active", "id", "name", "photo" FROM "Hobby";
DROP TABLE "Hobby";
ALTER TABLE "new_Hobby" RENAME TO "Hobby";
CREATE UNIQUE INDEX "Hobby_name_key" ON "Hobby"("name");
CREATE TABLE "new_User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "fullName" TEXT NOT NULL,
    "photo" TEXT,
    "email" TEXT
);
INSERT INTO "new_User" ("email", "fullName", "id", "photo") SELECT "email", "fullName", "id", "photo" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User_fullName_key" ON "User"("fullName");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

-- CreateIndex
CREATE UNIQUE INDEX "_HobbyToUser_AB_unique" ON "_HobbyToUser"("A", "B");

-- CreateIndex
CREATE INDEX "_HobbyToUser_B_index" ON "_HobbyToUser"("B");
