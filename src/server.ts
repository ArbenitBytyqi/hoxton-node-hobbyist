import express from 'express'
import cors from 'cors'
import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()
const app = express()
app.use(cors())
app.use(express.json())
const port = 5000

// USERS

app.get('/users' , async (req, res) => {
    const users = await prisma.users.findMany({ include: { hobbies: true } })
    res.send(users)
})

app.get('/users/:id', async (req, res) => {
    const user = await prisma.users.findUnique({ 
        where: { id: Number(req.params.id) }, 
        include: { hobbies: true }
    })
    if (user){
        res.send(user)
    }else {
        res.status(404).send({ error: 'User does not exists! 😒' })
    }
})

app.post('/users', async (req, res) => {
    const user = await prisma.users.create({ 
        data: req.body, 
        include: { hobbies: true } })
    res.send(user)
})

app.delete('/users/:id', async (req, res) => {
    const user = await prisma.users.delete({ where: { id: Number(req.params.id)} })
    res.send(user)
})

app.patch('/users/:id', async (req, res) => {
    const user = await prisma.users.update({ where: { id:Number(req.params.id) }, data: req.body })
    res.send(user)
})

// HOBBIES

app.get('/hobbies' , async (req, res) => {
    const hobbies = await prisma.hobbies.findMany({ include: { users: true } })
    res.send(hobbies)
})

app.get ('/hobbies/:id', async (req, res) => {
    const hobby = await prisma.hobbies.findUnique({
        where: { id: Number(req.params.id) },
        include: { users: true }
    })
    if (hobby){
        res.send(hobby)
    }else {
        res.status(404).send({ error: 'Hobby does not exists! 😒' })
    }
})

app.post('/hobbies', async (req, res) => {
    const hobby = await prisma.hobbies.create({ 
        data: req.body,
        include: { users: true }
    })
    res.send(hobby)
})

app.delete('/hobbies/:id', async (req, res) => {
    const hobby = await prisma.hobbies.delete({ where: { id: Number(req.params.id)} })
    res.send(hobby)
})

app.patch('/hobbies/:id', async (req, res) => {
    const hobby = await prisma.hobbies.update({ where: { id:Number(req.params.id) }, data: req.body })
    res.send(hobby)
})

// GENERAL

app.listen(port, () => {
    console.log(`Listening on port: http://localhost:${port}`)
})