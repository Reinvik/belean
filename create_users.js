
import { createClient } from '@supabase/supabase-js'

const supabaseUrl = 'http://127.0.0.1:54321'
const supabaseKey = 'sb_secret_N7UND0UgjKTVK-Uodkm0Hg_xSvEMPvz' // Service Role Key

const supabase = createClient(supabaseUrl, supabaseKey)

async function createUsers() {
    console.log("Creating users...")

    // Ariel
    const { data: u1, error: e1 } = await supabase.auth.admin.createUser({
        email: 'ariel.mellag@gmail.com',
        password: 'Equix123',
        email_confirm: true,
        user_metadata: { name: 'Ariel Mella' }
    })
    if (e1) console.log('Ariel status:', e1.message)
    else console.log('Created Ariel:', u1.user.id)

    // Equipo
    const { data: u2, error: e2 } = await supabase.auth.admin.createUser({
        email: 'Equipo@belean.cl',
        password: 'Belean123',
        email_confirm: true,
        user_metadata: { name: 'Equipo BeLean' }
    })
    if (e2) console.log('Equipo status:', e2.message)
    else console.log('Created Equipo:', u2.user.id)
}

createUsers()
