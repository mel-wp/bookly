const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const prisma = require('../prisma');

function generateToken(user) {
  return jwt.sign(
    {
      id: user.id,
      email: user.email,
    },
    process.env.JWT_SECRET,
    {
      expiresIn: '7d',
    },
  );
}

function userResponse(user) {
  return {
    id: user.id,
    name: user.name,
    email: user.email,
    createdAt: user.createdAt,
    updatedAt: user.updatedAt,
  };
}

async function register(req, res) {
  try {
    const { name, email, password } = req.body;

    if (!name || !email || !password) {
      return res.status(400).json({
        message: 'Nome, e-mail e senha são obrigatórios.',
      });
    }

    if (password.length < 6) {
      return res.status(400).json({
        message: 'A senha precisa ter pelo menos 6 caracteres.',
      });
    }

    const userAlreadyExists = await prisma.user.findUnique({
      where: { email },
    });

    if (userAlreadyExists) {
      return res.status(409).json({
        message: 'Já existe um usuário cadastrado com este e-mail.',
      });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    const user = await prisma.user.create({
      data: {
        name,
        email,
        password: hashedPassword,
      },
    });

    const token = generateToken(user);

    return res.status(201).json({
      user: userResponse(user),
      token,
    });
  } catch (error) {
    console.error(error);

    return res.status(500).json({
      message: 'Erro ao cadastrar usuário.',
    });
  }
}

async function login(req, res) {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({
        message: 'E-mail e senha são obrigatórios.',
      });
    }

    const user = await prisma.user.findUnique({
      where: { email },
    });

    if (!user) {
      return res.status(401).json({
        message: 'E-mail ou senha inválidos.',
      });
    }

    const passwordMatches = await bcrypt.compare(password, user.password);

    if (!passwordMatches) {
      return res.status(401).json({
        message: 'E-mail ou senha inválidos.',
      });
    }

    const token = generateToken(user);

    return res.json({
      user: userResponse(user),
      token,
    });
  } catch (error) {
    console.error(error);

    return res.status(500).json({
      message: 'Erro ao fazer login.',
    });
  }
}

async function me(req, res) {
  try {
    const authHeader = req.headers.authorization;

    if (!authHeader) {
      return res.status(401).json({
        message: 'Token não informado.',
      });
    }

    const [, token] = authHeader.split(' ');

    if (!token) {
      return res.status(401).json({
        message: 'Token inválido.',
      });
    }

    const decoded = jwt.verify(token, process.env.JWT_SECRET);

    const user = await prisma.user.findUnique({
      where: {
        id: decoded.id,
      },
    });

    if (!user) {
      return res.status(404).json({
        message: 'Usuário não encontrado.',
      });
    }

    return res.json(userResponse(user));
  } catch (error) {
    console.error(error);

    return res.status(401).json({
      message: 'Token inválido ou expirado.',
    });
  }
}

module.exports = {
  register,
  login,
  me,
};