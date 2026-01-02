
import { createClient } from '@supabase/supabase-js';

// Initialize Supabase client
const supabaseUrl = process.env.VITE_SUPABASE_URL;
const supabaseKey = process.env.VITE_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseKey) {
    console.error('Missing VITE_SUPABASE_URL or VITE_SUPABASE_ANON_KEY env vars');
    process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function checkNames() {
    console.log('--- Checking Responsibles ---');

    // 1. Get Users
    const { data: users, error: userError } = await supabase.from('profiles').select('name, email');
    if (userError) console.error('Error fetching profiles:', userError);
    else {
        console.log('\nUsers in DB (profiles):');
        users.forEach(u => console.log(` - "${u.name}" (${u.email})`));
    }

    // 2. Get 5S Responsibles
    const { data: fiveS, error: fiveSError } = await supabase.from('five_s_cards').select('responsible');
    if (fiveSError) console.error('Error fetching five_s_cards:', fiveSError);
    else {
        const unique = [...new Set(fiveS.map(i => i.responsible))].filter(Boolean).sort();
        console.log('\nDistinct Responsibles in 5S Cards:');
        unique.forEach(r => console.log(` - "${r}"`));
    }

    // 3. Get A3 Responsibles
    const { data: a3, error: a3Error } = await supabase.from('a3_projects').select('responsible, action_plan');
    if (a3Error) console.error('Error fetching a3_projects:', a3Error);
    else {
        const unique = new Set();
        a3.forEach(p => {
            if (p.responsible) unique.add(p.responsible);
            if (Array.isArray(p.action_plan)) {
                p.action_plan.forEach(a => {
                    if (a.responsible) unique.add(a.responsible);
                });
            }
        });
        console.log('\nDistinct Responsibles in A3 Projects & Actions:');
        [...unique].sort().forEach(r => console.log(` - "${r}"`));
    }
}

checkNames();
