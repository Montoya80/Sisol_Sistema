"use client";

import React from "react";
import { motion } from "framer-motion";
import { Shield, Rocket, Github, Database, Cloud, Star } from "lucide-react";

export default function Home() {
  return (
    <main className="min-h-screen bg-[#0a0a0a] text-white selection:bg-purple-500/30 overflow-hidden">
      {/* Dynamic Background */}
      <div className="fixed inset-0 z-0">
        <div className="absolute top-[-10%] left-[-10%] w-[40%] h-[40%] bg-purple-900/20 blur-[120px] rounded-full animate-pulse" />
        <div className="absolute bottom-[-10%] right-[-10%] w-[40%] h-[40%] bg-blue-900/20 blur-[120px] rounded-full animate-pulse delay-700" />
      </div>

      <div className="relative z-10 max-w-7xl mx-auto px-6 pt-24 pb-32">
        {/* Navigation / Header */}
        <nav className="flex justify-between items-center mb-16 backdrop-blur-md bg-white/5 border border-white/10 p-4 rounded-2xl">
          <div className="flex items-center gap-2">
            <div className="w-8 h-8 bg-gradient-to-tr from-purple-500 to-blue-500 rounded-lg flex items-center justify-center">
              <Star className="w-5 h-5 text-white" fill="white" />
            </div>
            <span className="font-bold text-xl tracking-tight">Sisol_Sistema</span>
          </div>
          <div className="flex gap-4">
            <button className="px-4 py-2 text-sm font-medium hover:text-purple-400 transition-colors">Docs</button>
            <button className="bg-white text-black px-5 py-2 rounded-xl text-sm font-bold hover:bg-slate-200 transition-all transform hover:scale-105 active:scale-95">
              Launch App
            </button>
          </div>
        </nav>

        {/* Hero Section */}
        <div className="text-center mb-24">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.8 }}
          >
            <span className="inline-block px-4 py-1.5 mb-6 text-xs font-semibold tracking-wider text-purple-400 uppercase bg-purple-400/10 border border-purple-400/20 rounded-full">
              Fullstack Integration Ready
            </span>
            <h1 className="text-6xl md:text-8xl font-black mb-8 bg-gradient-to-b from-white to-white/40 bg-clip-text text-transparent leading-tight">
              Build Faster. <br /> Scale Smarter.
            </h1>
            <p className="max-w-2xl mx-auto text-lg text-slate-400 mb-10 leading-relaxed">
              La base perfecta para tu próximo proyecto SaaS. Integración nativa con
              <strong> GitHub</strong>, <strong>Supabase</strong> y <strong>Dokploy</strong> para un flujo de trabajo profesional desde el primer día.
            </p>
          </motion.div>

          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <button className="px-8 py-4 bg-gradient-to-r from-purple-600 to-blue-600 rounded-2xl font-bold text-lg shadow-lg shadow-purple-500/20 hover:shadow-purple-500/40 transform hover:-translate-y-1 transition-all">
              Empieza Ahora
            </button>
            <button className="px-8 py-4 bg-white/5 border border-white/10 hover:bg-white/10 rounded-2xl font-bold text-lg backdrop-blur-sm transition-all">
              Ver Demo
            </button>
          </div>
        </div>

        {/* Features Grid */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          <FeatureCard
            icon={<Github className="w-6 h-6" />}
            title="GitHub Sync"
            description="Control de versiones y CI/CD integrado directamente con tu repositorio."
            delay={0.2}
          />
          <FeatureCard
            icon={<Database className="w-6 h-6" />}
            title="Supabase Backend"
            description="Autenticación, Base de Datos en tiempo real y Almacenamiento listos."
            delay={0.4}
          />
          <FeatureCard
            icon={<Cloud className="w-6 h-6" />}
            title="Dokploy Deploy"
            description="Despliegue autogestionado en tu propia infraestructura con un par de clics."
            delay={0.6}
          />
        </div>
      </div>

      {/* Footer */}
      <footer className="relative z-10 border-t border-white/10 mt-20 py-12 px-6 text-center text-slate-500">
        <p>© 2026 Premium Project Kit. Diseñado para el alto rendimiento.</p>
      </footer>
    </main>
  );
}

function FeatureCard({ icon, title, description, delay }: { icon: React.ReactNode, title: string, description: string, delay: number }) {
  return (
    <motion.div
      initial={{ opacity: 0, y: 30 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.8, delay }}
      className="group p-8 rounded-3xl bg-white/5 border border-white/10 hover:border-purple-500/50 hover:bg-white/[0.08] transition-all duration-500"
    >
      <div className="w-12 h-12 bg-purple-500/20 rounded-2xl flex items-center justify-center text-purple-400 mb-6 group-hover:scale-110 group-hover:bg-purple-500 group-hover:text-white transition-all duration-500">
        {icon}
      </div>
      <h3 className="text-xl font-bold mb-3">{title}</h3>
      <p className="text-slate-400 leading-relaxed">
        {description}
      </p>
    </motion.div>
  );
}
