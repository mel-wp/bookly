const prisma = require('../prisma');

function calculateLoanStatus(dueDate, returnedDate) {
  if (returnedDate) {
    return 'RETURNED';
  }

  const today = new Date();
  const due = new Date(dueDate);

  today.setHours(0, 0, 0, 0);
  due.setHours(0, 0, 0, 0);

  if (due < today) {
    return 'LATE';
  }

  return 'PENDING';
}

async function createLoan(req, res) {
  try {
    const {
      userId,
      friendId,
      bookId,
      loanDate,
      dueDate,
      notes,
      photoUrl,
    } = req.body;

    if (!userId || !friendId || !bookId || !dueDate) {
      return res.status(400).json({
        message: 'userId, friendId, bookId e dueDate são obrigatórios.',
      });
    }

    const userExists = await prisma.user.findUnique({
      where: { id: userId },
    });

    if (!userExists) {
      return res.status(404).json({
        message: 'Usuário não encontrado.',
      });
    }

    const friendExists = await prisma.friend.findUnique({
      where: { id: friendId },
    });

    if (!friendExists) {
      return res.status(404).json({
        message: 'Amigo não encontrado.',
      });
    }

    const bookExists = await prisma.book.findUnique({
      where: { id: bookId },
    });

    if (!bookExists) {
      return res.status(404).json({
        message: 'Livro não encontrado.',
      });
    }

    if (!bookExists.available) {
      return res.status(409).json({
        message: 'Este livro já está emprestado.',
      });
    }

    const loan = await prisma.$transaction(async (tx) => {
      const createdLoan = await tx.loan.create({
        data: {
          userId,
          friendId,
          bookId,
          loanDate: loanDate ? new Date(loanDate) : new Date(),
          dueDate: new Date(dueDate),
          status: calculateLoanStatus(dueDate, null),
          notes,
          photoUrl,
        },
        include: {
          friend: true,
          book: true,
        },
      });

      await tx.book.update({
        where: { id: bookId },
        data: {
          available: false,
        },
      });

      return createdLoan;
    });

    return res.status(201).json(loan);
  } catch (error) {
    console.error(error);

    return res.status(500).json({
      message: 'Erro ao criar empréstimo.',
    });
  }
}

async function listLoans(req, res) {
  try {
    const { userId, status } = req.query;

    const where = {};

    if (userId) {
      where.userId = userId;
    }

    if (status) {
      where.status = status;
    }

    const loans = await prisma.loan.findMany({
      where,
      orderBy: {
        dueDate: 'asc',
      },
      include: {
        friend: true,
        book: true,
      },
    });

    return res.json(loans);
  } catch (error) {
    console.error(error);

    return res.status(500).json({
      message: 'Erro ao listar empréstimos.',
    });
  }
}

async function getLoanById(req, res) {
  try {
    const { id } = req.params;

    const loan = await prisma.loan.findUnique({
      where: { id },
      include: {
        friend: true,
        book: true,
      },
    });

    if (!loan) {
      return res.status(404).json({
        message: 'Empréstimo não encontrado.',
      });
    }

    return res.json(loan);
  } catch (error) {
    console.error(error);

    return res.status(500).json({
      message: 'Erro ao buscar empréstimo.',
    });
  }
}

async function updateLoan(req, res) {
  try {
    const { id } = req.params;

    const {
      friendId,
      bookId,
      loanDate,
      dueDate,
      returnedDate,
      status,
      notes,
      photoUrl,
    } = req.body;

    const loanExists = await prisma.loan.findUnique({
      where: { id },
    });

    if (!loanExists) {
      return res.status(404).json({
        message: 'Empréstimo não encontrado.',
      });
    }

    const data = {};

    if (friendId) data.friendId = friendId;
    if (bookId) data.bookId = bookId;
    if (loanDate) data.loanDate = new Date(loanDate);
    if (dueDate) data.dueDate = new Date(dueDate);
    if (returnedDate) data.returnedDate = new Date(returnedDate);
    if (status) data.status = status;
    if (notes !== undefined) data.notes = notes;
    if (photoUrl !== undefined) data.photoUrl = photoUrl;

    if (!status && dueDate) {
      data.status = calculateLoanStatus(dueDate, returnedDate);
    }

    const loan = await prisma.loan.update({
      where: { id },
      data,
      include: {
        friend: true,
        book: true,
      },
    });

    return res.json(loan);
  } catch (error) {
    console.error(error);

    return res.status(500).json({
      message: 'Erro ao atualizar empréstimo.',
    });
  }
}

async function markLoanAsReturned(req, res) {
  try {
    const { id } = req.params;

    const loanExists = await prisma.loan.findUnique({
      where: { id },
      include: {
        book: true,
      },
    });

    if (!loanExists) {
      return res.status(404).json({
        message: 'Empréstimo não encontrado.',
      });
    }

    const loan = await prisma.$transaction(async (tx) => {
      const updatedLoan = await tx.loan.update({
        where: { id },
        data: {
          returnedDate: new Date(),
          status: 'RETURNED',
        },
        include: {
          friend: true,
          book: true,
        },
      });

      await tx.book.update({
        where: { id: loanExists.bookId },
        data: {
          available: true,
        },
      });

      return updatedLoan;
    });

    return res.json(loan);
  } catch (error) {
    console.error(error);

    return res.status(500).json({
      message: 'Erro ao marcar empréstimo como devolvido.',
    });
  }
}

async function deleteLoan(req, res) {
  try {
    const { id } = req.params;

    const loanExists = await prisma.loan.findUnique({
      where: { id },
    });

    if (!loanExists) {
      return res.status(404).json({
        message: 'Empréstimo não encontrado.',
      });
    }

    await prisma.$transaction(async (tx) => {
      await tx.loan.delete({
        where: { id },
      });

      await tx.book.update({
        where: { id: loanExists.bookId },
        data: {
          available: true,
        },
      });
    });

    return res.json({
      message: 'Empréstimo removido com sucesso.',
    });
  } catch (error) {
    console.error(error);

    return res.status(500).json({
      message: 'Erro ao remover empréstimo.',
    });
  }
}

module.exports = {
  createLoan,
  listLoans,
  getLoanById,
  updateLoan,
  markLoanAsReturned,
  deleteLoan,
};