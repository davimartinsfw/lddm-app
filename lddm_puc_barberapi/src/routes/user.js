import { Router } from 'express'
import UserController from '../controllers/user'
const router = Router()

router.get('/', async (req, res, next) => {
    try {
        res = UserController.get()
        return res
    } catch(e) {
        
    }
})

router.post('/create', async (req, res, next) => {
    try {
        res = UserController.create(req.body)
    } catch(e) {
        
    }
})

router.post('/update/:id', async (req, res, next) => {
    try {
        res = UserController.update(req)
    } catch(e) {
        
    }
})

router.delete('/delete/:id', async (req, res, next) => {
    try {
        res = UserController.remove(req)
    } catch(e) {
        
    }
})
