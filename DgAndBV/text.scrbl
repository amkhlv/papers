#lang scribble/base
@(require racket scribble/core scribble/base scribble/html-properties)
@(require "defs.rkt" bystroTeX/common bystroTeX/slides (for-syntax bystroTeX/slides_for-syntax))
@; ---------------------------------------------------------------------------------------------------
@; User definitions:
@(bystro-set-css-dir (build-path (find-system-path 'home-dir) "a" "git" "amkhlv" "profiles" "writeup"))
@(define bystro-conf   
   (bystro (bystro-connect-to-server (build-path (find-system-path 'home-dir) ".config" "amkhlv" "latex2svg.xml"))
           "text/formulas.sqlite"  ; name for the database
           "text" ; directory where to store image files of formulas
           25  ; formula size
           (list 255 255 255) ; formula background color
           (list 0 0 0) ; formula foreground color
           2   ; automatic alignment adjustment
           0   ; manual alignment adjustment
           ))
@(define singlepage-mode #f)
@(bystro-def-formula "formula-enormula-humongula!")

@(define (bystro-bg0) (bystro-bg 255 255 255))

@(require bystroTeX/bibtex)

@title[#:style '(no-toc no-sidebar)]{DGLA Dg and BV formalism}




@bystro-toc[]

@use-LaTeX-preamble{
\newcommand{\ashriek}{¡}
\newcommand{\intoper}{ℐ}
\newcommand{\intfam}{ℑ}
}

@page["Introduction" #:tag "Introduction" #:showtitle #t]

BV formalism is a generalization of the BRST formalism, based on the mathematical theory of
odd symplectic supermanifolds. In this formalism the path integral is interpreted as
an integral of a density of weight @f{1/2} over a Lagrangian submanifold. It turns out that
this ``standard'' formulation is not sufficient to describe string worldsheet theory.
One has to also consider integration over @bold{families} of Lagrangian submanifolds.
Indeed, the idea of @cite{Schwarz:2000ct} was to interpret integration over the worldsheet metrics
as a particular case of integration over the space of gauge fixing conditions.
Varying the worldsheet metric is a particular case of varying the Lagrangian submanifold.
Taking into account the worldsheet diffeomorphism invariance requires an equivariant
version of this integration procedure.
(In a sense, worldsheet metric is not necessarily a preferred object. Varying the worldsheet
    metric is just one way to build an integration cycle, there are others. The worldsheet
    diffeomorphisms, however, @bold{are} special.)
                                           

It was developed in @cite{Mikhailov:2016myt}
and @cite{Mikhailov:2016rkp}. The construction of equivariant form
involves a map of some differential graded Lie algebra (DGLA)  @f{D\bf g} into the algebra of functions
on the BV phase space of the string sigma-model.
To the best of our knowledge, @f{D\bf g} was first introduced, or at least clearly presented,
in  @cite{Alekseev:2010gr}.
Here we will rederive some constructions of @cite{Mikhailov:2016myt},@cite{Mikhailov:2016rkp}
using an algebraic language which emphasizes the DGLA structure,
and apply some results of  @cite{Alekseev:2010gr} to the study of worldsheet vertex operators.
In a sense, @f{D\bf g} is a ``universal structure''
in equivariant BV formalism, @italic{i.e.} the ``worst-case scenario'' in terms of complexity.
The construction of @f{D\bf g} is a generalization of the construction
of the ``cone'' superalgebra @f{C\bf g} (which is called ``supersymmetrized Lie superalgebra''
                                               in @cite{Cordes:1994fc}).

We will now briefly outline these constructions, and the results of the present paper.

@subpage[1 "The cone of Lie superalgebra" #:tag "sec:IntroCone"]
     
For every Lie superalgebra @f{\bf a}, we can define a
Differential Graded Lie superalgebra @f{C\bf a} (the ``cone'' of @f{\bf a}) as follows.
Consider a graded vector space:
@e{
   C{\bf a} = {\bf a}\oplus s{\bf a}
   }
where @f{\bf a} is at grade zero, and @f{s{\bf a}} at grade @f{-1}. (The letter @f{s} means ``suspension''.)
We consider vector superspace @f{\bf a} as a graded vector space, such
that the grade of all elements is zero. Then, we denote @f{s{\bf a}} the vector space @f{\bf a} with
flipped statistics  at degree @f{-1}.
@comment{In our conventions, ``grade'' corresponds to the ``ghost number'';
             statistics is @bold{not} grade mod 2.}
The commutator is defined as follows. The commutator of two elements of @f{{\bf a}\subset {\bf a}\oplus s{\bf a}}
is the commutator of @f{\bf a}, the commutator of two elements of @f{s\bf a} is zero,
@f{s{\bf a} \subset {\bf a} \oplus s{\bf a}} is an ideal, the action of @f{\bf a} on @f{s\bf a}
corresponds to the adjoint representation of @f{\bf a}. The differential @f{d_{C\bf a}} is zero on @f{\bf a}
and maps elements of @f{s\bf a} to the elements of @f{\bf a}, @italic{i.e.}:
@f{d_{C\bf a} (sx) = x}.

This construction has an important application in differential geometry. If @f{\bf a} acts
on a manifold @f{M}, then @f{C{\bf a}} acts on differential forms on @f{M}. The same applies
to supermanifolds and pseudo-differential forms (PDFs) on @f{M}. The elements of @f{{\bf a}\subset {\bf a} \oplus s{\bf a}}
act as Lie derivatives. For each @f{x\in {\bf a}} we denote @f{{\cal L}\langle x\rangle} the corresponding
Lie derivative. The elements of @f{s{\bf a}\subset {\bf a} \oplus s{\bf a}} act as ``contractions''.
For @f{x\in {\bf a}}, the contraction will be denoted @f{\iota\langle x\rangle}.
(We use angular brackets @f{f\langle x\rangle} when @f{f} is a linear function, to highlight linear dependence on @f{x}.)
We have:
@(align
  r.l.n
  `(@,f{d \iota\langle x\rangle \;=\;} @,f{{\cal L}\langle x\rangle} @,label{DefCone})
  `(@,f{d {\cal L}\langle x\rangle \;=\;} @,f{0} "")
  )
          


@subpage[1 @f{D\bf g} #:tag "sec:IntroDg"]

The definition of @f{D\bf g} is similar to the definition of @f{C\bf g}. Essentially, we replace
the commutative ideal  @f{s{\bf g}\subset C{\bf g}} with a free Lie superalgebra of the linear space
@f{s^{-1}\mbox{Symm}(s^2{\bf g})} where @f{\mbox{Symm}(s^2{\bf g})} is the space of symmetric
tensors of @f{s^2\bf g}. 
Instead of defining  the commutators to be zero, we only require that some linear combinations of
commutators are @f{d_{D\bf g}}-exact. Eq. (@ref{DefCone}) is replaced with:
@(align
  r.l.n
  `(@,f{di(x) + {1\over 2}[i(x),i(x)] \;=\;} @,f{l\langle x\rangle} @,label{IntroDefDg})
  `(@,f{dl\langle x\rangle \;=\;} @,f{0} "")
  `(@,f{[l\langle x\rangle , l\langle y\rangle] \;=\;} @,f{l\langle [x,y] \rangle} "")
  )
In particular, if @f{i(x)} is a linear function of @f{x}, then @f{D\bf g} becomes @f{C\bf g}.
In 〚@seclink["DefDg"]{@secref{DefDg}}〛 we explain the details of the construction, and why it is
very natural. We slightly generalize it, by allowing @f{\bf g} to be  a  Lie superalgebra
(while in @cite{Alekseev:2010gr} it was a Lie algebra).



@subpage[1 "String measure" #:tag "sec:IntroStringMeasure"]

In BV formalism, to every half-density @f{\rho_{1/2}} satisfying the Quantum Master Equation corresponds
a closed PDF on the space of Lagrangian submanifolds, which we denote @f{\Omega}
@cite{Mikhailov:2016myt},@cite{Mikhailov:2016rkp}. Besides being closed, it satisfies the following
very special property:
@e[#:label "SpecialPropertyOfOmega"]{
   d\iota\langle  x\rangle \;\Omega\;=\; \iota\langle{\Delta x}\rangle \;\Omega
   }
where @f{x\in\bf a}, @f{\bf a} is the algebra of functions on the BV phase space, 
and @f{\Delta} is some differential on @f{\bf a}, which is associated to the half-density @f{\rho_{1/2}}.
This form @f{\Omega} is @bold{inhomogeneous},
@italic{i.e.} does not have a definite rank. It is, generally speaking, a pseudo-differential form (PDF).
Otherwise, Eq. (@ref{SpecialPropertyOfOmega}) would not make sense.
We rederive @f{\Omega} in
〚@seclink["sec:CorrelationFunctionsAreCocycle"]{@secref{sec:CorrelationFunctionsAreCocycle}}〛.

@subpage[1 "Equivariant string measure" #:tag "sec:IntroEquivariant"]

Let @f{{\bf g}\subset {\bf a}} be the algebra of vector fields on the worldsheet.
In the BV approach to string worldsheet theory,  worldsheet diffeomorphisms are symmetries of @f{\rho_{1/2}},
and therefore   @f{\Omega} is @f{\bf g}-invariant. We are interested in constructing the @f{{\bf g}}-equivariant version of @f{\Omega}.
Generally speaking, there is no good algorithm for constructing an equivariant PDF out of an invariant PDF.
But in our case, since @f{\Omega} satisfies Eq. (@ref{SpecialPropertyOfOmega}), we can reduce the construction
of equvariant form to the construction of a an embedding  @f{{D\bf g}\rightarrow {\bf a}}
--- see 〚@seclink["AnsatzForEquivariantForm"]{@secref{AnsatzForEquivariantForm}}〛.

@subpage[1 "Vertex operators" #:tag "sec:IntroVertexOperators"]

Consider @bold{deformations} of @f{\Omega}. In string theory context they are called ``vertex operators''.
It is useful to consider deformations which break some of the symmetries. Typically, we insert
some operators at some points on the wordsheet, breaking the diffeomorphisms down to the subgroup preserving
that set of points. This is the ``unintegrated vertex operator''. Then, there exists an averaging
procedure which restores the symmetry group back to all diffeomorphisms.
The result of this averaging is effectively an insertion of ``integrated vertex operator'' which preserves
all the diffeomorphisms. This relation between unintegrated and integrated vertex operators is important
in string theory.

As we show in 〚@seclink["IntegratedAndUnintegrated"]{@secref{IntegratedAndUnintegrated}}〛,
this averaging procedure requires an action of @f{D\bf g}. This may be surprizing, because
symmetries act by @f{l\langle x\rangle}  of Eq. (@ref{IntroDefDg}). Just to define the action of
symmetries, we only need @f{l\langle x\rangle}. But the averaging procedure,
which is needed to compute string amplitudes, does involve @f{i(x)}. 


In previously studied cases, such as bosonic or NSR string, @f{D\bf g} reduces to @f{C\bf g},
and @f{i(x)} is rather simple. The averaging procedure consists of just removing the ghost field from the vertex,
and then integration over the insertion point.
In Section 〚@seclink["IntegratedAndUnintegrated"]{@secref{IntegratedAndUnintegrated}}〛
we derive the general formula, which is rather nontrivial and uses some intertwining
operator constructed in @cite{Alekseev:2010gr}.


At this time, we do not have concrete examples of string worldsheet theories where @f{D\bf g} would
not enter only through the projection to @f{C{\bf g}}. It is likely that pure spinor superstring in AdS
background is an example, but we only have a partial construction @cite{Mikhailov:2017mdo}.


@subpage[1 "Previous work" #:tag "sec:PreviousWork"]




Previous work on equivariant BV formalism includes
@cite{Nersessian:1993me}, @cite{Nersessian:1993eq}, @cite{Nersessian:1995yt},
@cite{Getzler:2015jrr}, @cite{Getzler:2016fek}, @cite{Cattaneo:2016zrn}, @cite{Getzler:2018sbh},
@cite{Bonechi:2019dqk}.
Similar algebraic structures appeared recently (in a different context?) in @cite{Bonezzi:2019bek} and
references therein.




@page["Notations" #:tag "Notations" #:showtitle #t]


When a function @f{f(x)} depends on @f{x} linearly, we will write:
@e{
   f\langle x\rangle \quad\mbox{\tt instead of}\quad f(x)
   }
to stress linearity.
The cone of the Lie superalgebra @f{\bf g} is:
@e{
   C{\bf g} = {\bf g} \stackrel{\rightarrow}{\oplus} s{\bf g}
   }
where @f{\stackrel{\rightarrow}{\oplus}} stands for semidirect sum of Lie superalgebras, with arrow pointing towards the ideal,
and @f{s} is suspension, of degree @f{-1}. (We consider @f{\bf g} as a graded vector space, all having
                                               degree zero, then @f{s\bf g} all has degree @f{-1}.)
@comment{
         It may seem strange to assign degree @f{-1} to @f{s}, instead of degree @f{+1}.
         In string theory context, we want the grade to be the ghost number.
         At the same time, we do not want to replace @f{s} with @f{s^{-1}}, because we want
         to agree with the notations of @cite{LodayVallette}.
         }
Throughout the paper we will follow
@hyperlink["http://irma.math.unistra.fr/~loday/PAPERS/LodayVallette.pdf"]{the notations}
of @cite{LodayVallette}.
From a vector space @f{V} over a field @f{\bf K} (for us @f{{\bf K} ={\bf R}}) we construct
an algebra @f{A}, which consists of tensors of @f{V} modulo some quadratic relations @f{R\subset V\otimes V}.
The coalgebra @f{A^{\ashriek}} consists of tensors of @f{sV}, such that the tensor product of
any pair of neighbor @f{V} fall into @f{s^2R}. 
The cobar construction of @f{A^{\ashriek}} is denoted @f{\Omega\left(A^{\ashriek}\right)}.

One motivation for using the formalism of quadratic algebras is technical, as it automates
keeping track of signs. 
We will translate into ``more elementary'' language of @cite{Alekseev:2010gr} in 
〚@seclink["sec:FunctionsOfCurvature"]{@secref{sec:FunctionsOfCurvature}}〛.

PDF = pseudo-differential form.

Hyperlinks to web content @hyperlink["https://andreimikhailov.com/math/bv/omega/Equivariant_half-densities.html"]{are highlighted blue}.

@page[@elem{@f{D\bf g}} #:tag "DefDg" #:showtitle #t]

@bystro-local-toc[]

@subpage[1 @elem{Definition of @f{D\bf g}} #:tag "sec:DefDg"]

As far as we know, @f{D\bf g} was introduced in @cite{Alekseev:2010gr}, in the context of current algebras.
We will now present it in the language of quadratic algebras.

@subpage[2 @elem{Definitions of @f{A}, @f{A^{\ashriek}} and @f{\Omega(A^{\ashriek})}} #:tag "sec:DefA"]

Let @f{\bf g} be a Lie superalgebra. We consider the suspended linear superspace
@f{s\bf g}, and a supercommutative algebra @f{A} freely generated by it.

Consider its quadratic dual coalgebra:
@e{
   A^{\ashriek} \subset T^c(s^2{\bf g})
   }
Here the index @f{c} in @f{T^c} indicates that we consider the space of tensor products as a coalgebra.
(If we considered it as an algebra, would have called it @f{T^a}.)
At this point, we consider @f{s{\bf g}} only as a supercommutative algebra.
The Lie algebra structure on @f{\bf g} is forgotten. 

Let us consider the cobar construction of @f{A^{\ashriek}}:
@e{
   \Omega\left( A^{\ashriek}\right) = T^a\left(s^{-1}  \overline{A^{\ashriek}}\right)
   }
Now the index @f{a} in @f{T^a} means that we consider tensors as forming an algebra, the free algebra.
The overline over @f{A^{\ashriek}} means that we remove
the counit, see @cite{LodayVallette} for precise definitions.
But we, for the reason which will become clear, need a Lie superalgebra, not an associative algebra.
Consider a subspace:
@e{
   \mbox{FreeLie}\left(s^{-1}  \overline{A^{\ashriek}}\right) \subset   \Omega\left( A^{\ashriek}\right)
   }
which is generated by commutators. Consider the natural twisting morphism
@(align
  r.l.n
  `(@,f{\alpha \;:\;}
       @,f{A^{\ashriek} \rightarrow \Omega\left( A^{\ashriek}\right)}
       "")
  )
Its image belongs to @f{s^{-1}  A^{\ashriek}\subset \mbox{FreeLie}\left(s^{-1}  \overline{A^{\ashriek}}\right)}. It satisfies
the Maurer-Cartan equation:
@e[#:label "MCAlpha"]{
   d_{\Omega} \alpha + \alpha * \alpha = 0
   }
where @f{d_{\Omega}} is the differential on @f{\Omega\left( A^{\ashriek}\right)} induced by
the coalgebra structure on @f{A^{\ashriek}}. Since @f{A} is a commutative algebra, @f{\alpha * \alpha} actually belongs to a subspace:
@e{
   \mbox{Hom}\left( A^{\ashriek}\,,\,\mbox{FreeLie}\left(s^{-1}  \overline{A^{\ashriek}}\right)\right)
   \subset
   \mbox{Hom}\left( A^{\ashriek}\,,\, \Omega\left( A^{\ashriek}\right)\right)
   }
We may denote it @f{{1\over 2}[\alpha\stackrel{*}{,}\alpha]}.
The differential @f{d_{\Omega}} preserves the subspace
@f{\mbox{FreeLie}\left(s^{-1}  \overline{A^{\ashriek}}\right)\subset \Omega(A^{\ashriek})}.
Therefore, @f{\mbox{FreeLie}\left(s^{-1}  \overline{A^{\ashriek}}\right)} with @f{d_{\Omega}} is a differential graded Lie superalgebra.

@subpage[2 @elem{Definition of @f{D\bf g}} #:tag "subsec:Dg"]

Let us consider a larger algebra:
@e[#:label "SemidirectSum"]{
   D{\bf g} \;=\; {\bf g} \stackrel{\rightarrow}{\oplus} \mbox{FreeLie}\left(s^{-1}  \overline{A^{\ashriek}}\right)
   }
Here @f{\stackrel{\rightarrow}{\oplus}} stands for semidirect sum of Lie superalgebras, with arrow pointing towards the ideal.
The embedding of @f{\bf g} into @f{D\bf g} as the first summand will be denoted @f{l}:
@e[#:label "EmbeddingL"]{
   l\;:\;{\bf g} \rightarrow D{\bf g}
   }


@bold{Commutator of @f{D\bf g}}


@(itemlist
  @item{
        The commutator of two elements of @f{\mbox{FreeLie}\left(s^{-1}  \overline{A^{\ashriek}}\right)} is the commutator
        of free Lie algebra.
        }
  @item{
        The commutator of two elements of @f{\bf g} is the commutator of @f{\bf g}.
        }
  @item{        
        The commutator of elements of @f{\bf g} and elements of @f{\mbox{FreeLie}\left(s^{-1}  \overline{A^{\ashriek}}\right)}
        corresponds to the natural action of @f{\bf g} on @f{A^{\ashriek}}.
        }
  )
When considering a commutator of an element of  @f{\bf g} and an element of @f{\mbox{FreeLie}\left(s^{-1} \overline{A^{\ashriek}}\right)},
the following description is useful.
Consider the @f{UC\bf g} -- the universal enveloping algebra of @f{C\bf g}, and its
dual coalgebra @f{UC{\bf g}^{\ashriek}}:
@e{
   UC{\bf g}^{\ashriek} = T^c\left(s({\bf g} \oplus s{\bf g})\right)
   }
Consider the projector @f{p}:
@(align
  r.l.n
  `(@,f{p\;:\;}
       @,f{UC{\bf g}^{\ashriek}\rightarrow s{\bf g}\oplus A^{\ashriek}}
       @,label{ProjectorP})
  )
which is identity on @f{s{\bf g}\oplus A^{\ashriek}\;\subset\;T^c\left(s({\bf g} \oplus s{\bf g})\right)}
and zero on all tensors of rank @f{\geq 2} containing at least one @f{sx \in s{\bf g}}.
This induces a map from @f{\Omega^1 \left(UC{\bf g}^{\ashriek}\right)} to @f{D\bf g} which we also
denote @f{p}:
@e[#:label "LiftedProjectorP"]{
   \Omega^1 \left(UC{\bf g}^{\ashriek}\right) =
   s^{-1}UC{\bf g}^{\ashriek}
   \stackrel{p}{\longrightarrow}
   {\bf g}\oplus s^{-1}A^{\ashriek} \subset D{\bf g}
   }
For any Lie superalgebra @f{\bf a} let @f{\gamma} denote the commutator map:
@(align
  r.l.n
  `(""
    @,f{\gamma\;:\; {\bf a}\otimes {\bf a} \rightarrow {\bf a}}
    "")
  `(""
    @,f{\gamma(v\otimes w) = [v,w]}
    "")
  )
In case of @f{{\bf a} = D{\bf g}}, we can consider @f{D{\bf g} \otimes D{\bf g}} as
a subspace in @f{\Omega^2(UC{\bf g}^{\ashriek})} using the projector @f{p} of Eq. (@ref{LiftedProjectorP}):
@e{
   p\otimes p \;:\; \Omega^2(UC{\bf g}^{\ashriek}) \rightarrow D{\bf g} \otimes D{\bf g}
   }
Then, the commutator on @f{D{\bf g}} satisfies:
@(align
  r.l.n
  `(""
    @,f{
        \gamma\;(p\otimes p)\; d_{\Omega(UC{\bf g}^{\ashriek})} \;s^{-1}b \;=\; - s^{-1} d_{UC{\bf g}^{\ashriek}}b
        }
    "")
  `(@,elem[#:style 'no-break]{where@hspace[1]}
          @,v+[4 @f{b\;=\;s\xi\otimes a + (-)^{(\xi+1)a} a\otimes s\xi\;\in\;UC{\bf g}^{\ashriek}}]
          "")
  `(""
    @,f{\xi\in {\bf g}\;,\quad a\in A^{\ashriek}}
    "")
  )


@bold{Differential @f{d'} of @f{D\bf g}}

There is a natural projection:
@e{
   \pi \;:\; A^{\ashriek} \rightarrow s^2{\bf g}
   }
annihilating all tensors with rank @f{\geq 1}
(@italic{i.e.} @f{\mbox{ker}\pi = \left(A^{\ashriek}\right)^{\geq 1}}).
We define a differential @f{d'} on @f{{\bf g} \stackrel{\rightarrow}{\oplus} \mbox{FreeLie}\left(s^{-1} \overline{A^{\ashriek}}\right)}, in the following way.
@(itemlist
  @item{We postulate that the action of @f{d'} on @f{\bf g} be zero:
@e[#:label "DPrimeOnG"]{
                        d'|_{\bf g} = 0
                        }
}
  @item{Since @f{\mbox{FreeLie}} is a left adjoint to the forgetful
              functor, we just need to define the action of @f{d'} on
              @f{s^{-1}  A^{\ashriek} \subset \mbox{FreeLie}\left(s^{-1}  \overline{A^{\ashriek}}\right)}. 
We put:
@e[#:label "DPrimeOnA"]{
                        d'|_{s^{-1}  A^{\ashriek}} = s^{-1}\circ\pi \;:\; s^{-1}  A^{\ashriek} \rightarrow {\bf g}
                        }
}
  )
We then extend Eqs. (@ref{DPrimeOnG}) and (@ref{DPrimeOnA}) to the differential @f{d'} of 
@f{{\bf g}\stackrel{\rightarrow}{\oplus}\mbox{FreeLie}\left(s^{-1}  \overline{A^{\ashriek}}\right)}.

We will now prove that @f{d'} anticommutes with @f{d_{\Omega}}:
@e[#:label "DsAnticommute"]{
   d'd_{\Omega} + d_{\Omega} d' = 0
   }
When @f{b\in \left(A^{\ashriek}\right)^{(\geq 2)}},
by definition @f{d' s^{-1}b =0}. We must therefore check that @f{d' d_{\Omega} s^{-1}b=0}:
@e{
   d' d_{\Omega} s^{-1}b = \gamma (p\otimes p) d_{\Omega(UC{\bf g}^{\ashriek})} s^{-1} d_{C\bf g} b =
   - s^{-1} d_{UC{\bf g}^{\ashriek}}d_{C\bf g}b =
   s^{-1} d_{C\bf g} d_{UC{\bf g}^{\ashriek}} b = 0
   }

We consider  @f{{\bf g} \stackrel{\rightarrow}{\oplus} \mbox{FreeLie}\left(s^{-1} \overline{A^{\ashriek}}\right)} with the differential @f{d_{\Omega} + d'} which will be called @f{d_{D\bf g}}:
@e{
   d_{D\bf g}=d_{\Omega} + d'
   }



@subpage[1 "Representation as vector fields" #:tag "sec:RepVect"]

Consider the @bold{cone} of our free Lie algebra:
@(align
  r.l.n
  `(@,f{{\cal C} \;=\;}
       @,f{C(\mbox{FreeLie}\left(s^{-1}  \overline{A^{\ashriek}}\right))}
       "")
  `(@,f{{\cal L}\;:\;}
    @,f{\mbox{FreeLie}\left(s^{-1}  \overline{A^{\ashriek}}\right)
             \longrightarrow C(\mbox{FreeLie}\left(s^{-1}  \overline{A^{\ashriek}}\right))}
       "")
  `(@,f{\iota\;:\;}
    @,f{\mbox{FreeLie}\left(s^{-1}  \overline{A^{\ashriek}}\right)
          \longrightarrow C(\mbox{FreeLie}\left(s^{-1}  \overline{A^{\ashriek}}\right))}
       "")
  )
and its universal enveloping algebra @f{U{\cal C}}. Eq. (@ref{MCAlpha}) implies:
@(align
  r.l.n
  `[""
    @,f{
        (d_{\cal C} + d_{\Omega}) \exp(-\iota\circ\alpha) =
        \exp(-\iota\circ\alpha) (d_{\cal C} + d_{\Omega} + {\cal L}\circ\alpha)
        }
    @,label{DWithExp}]
  )
This is an equation in the completion of @f{\mbox{Hom}\left( A^{\ashriek}\,,\,U{\cal C}\right)}, and @f{\exp(x)} is understood as
@f{1 + x + {1\over 2} x*x + \ldots}.

Let @f{M} be some supermanifold, and @f{\mbox{Vect}(M)} the algebra of vector fields on it.
Suppose that we are given a map of linear spaces:
@e{
   s^{-1}  A^{\ashriek} \rightarrow \mbox{Vect}(M)
   }
Such a map defines a representation of @f{\cal C} in the space of pseudo-differential forms (PDFs) on @f{M}.
We want to project Eq. (@ref{DWithExp}) on the space of PDFs on @f{M}. It is not possible to do directly,
because we do not require that @f{d_{\Omega}} act on PDFs.
Instead, consider the following version of Eq. (@ref{DWithExp}):
@(align
  r.l.n
  `(""
    @,f{
        d_M \exp(-\iota\circ\alpha) \omega =
        \exp(-\iota\circ\alpha) (d_M + \iota\circ (d_{\Omega}\alpha) + {\cal L}\circ\alpha)\omega
        }
    @,label{DMwithExpIota})
  `(""
    @,f{\omega \in \mbox{Hom}( A^{\ashriek},\mbox{Fun}(\Pi T M))}
    "")
  )
for all @f{\omega \in \mbox{Hom}( A^{\ashriek},\mbox{Fun}(\Pi T M))}. 


@subpage[1 "Ghost fields" #:tag "sec:DualAlgebraOfFunctions"]

Remember that we start with @f{A} --- the free super-commutative algebra generated by
the linear superspace @f{V = s{\bf g}}. Elements of @f{A} are symmetric tensors
in @f{V\otimes\cdots\otimes V}. (The @bold{relations} of @f{A},
          on the contrary, are antisymmetric tensors in @f{V\otimes V}.)

Then, elements of @f{A^{\ashriek}} are symmetric tensors
in @f{sV\otimes\cdots\otimes sV}. 

@subpage[2 "Example" #:tag "sec:ExamleAntiShriek"]

Let @f{a\in V,\,b\in V} be even and @f{\psi\in V,\,\eta\in V} be odd.
The following tensors belong to @f{A}:
@e{
   a\otimes b + b\otimes a\,,\;
   a\otimes \xi + \xi\otimes a\,,\;
   \xi\otimes\eta - \eta\otimes\xi
   }
The bar construction is:
@(align
  r.l.n
  `(""
    @,f{BA = T^c(s\overline{A})}
    "")
  `(""
    @,f{d_B(sx\otimes_B sy) = (-1)^{\bar{x}} sxy}
    "")
  )
The subspace @f{A^{\ashriek}\subset BA} is annihilated by @f{d_B} @bold{because of relations} of @f{A}.
In particular, the following are elements of @f{A^{\ashriek}}:
@e{
   sa\otimes sb - sb\otimes sa\,,\;
   sa\otimes s\psi + s\psi \otimes sa\,,\;
   s\psi\otimes s\eta + s\eta \otimes s\psi
   }
These are @bold{symmetric tensors} in @f{sV}.

To summarize, if @f{A} is the algebra of symmetric tensors in @f{V},
then @f{A^{\ashriek}} is the coalgebra of symmetric tensors in @f{sV}.

@subpage[2 @elem{Standard notations} #:tag "sec:FunctionsOfCurvature"]

For us @f{V = s{\bf g}}, therefore @f{A^{\ashriek}} is the coalgebra
of symmetric tensors in @f{s^2\bf g}. Therefore, the space @f{\mbox{Hom}\left(A^{\ashriek},L\right)}
can be thought of as the space of formal Taylor series of functions on the superspace @f{s^2\bf g}
with values in a linear superspace @f{L}.
The subspace @f{\mbox{Hom}\left(\left(A^{\ashriek}\right)^n,L\right)},
where @f{\left(A^{\ashriek}\right)^n} consists of rank @f{n} tensors, is the space
of @f{n}-th coefficients of the Taylor series. In particular, we interpret
@f{\mbox{Hom}( A^{\ashriek},\mbox{Fun}(\Pi T M))} as the space of functions on the supermanifold
@f{s^2{\bf g} \times \Pi TM}:
@e{
   \mbox{Hom}\left(
                   A^{\ashriek},\mbox{Fun}(\Pi T M)
                   \right) \simeq \mbox{Fun} (s^2{\bf g}\times \Pi TM)
   }
where @f{\simeq} means that we are not being rigorous. We ignore the question of which functions are allowed,
@italic{i.e.} do not explain the precise meaning of @f{\mbox{Fun}(\ldots)}.


Let @f{\{e_a\}} denote some basis in @f{s^2\bf g}, and
@f{\{F^a\}} the dual basis in the space @f{s^{-2}{\bf g}^*} of linear functions on @f{\bf g}:
@e{
   F^a \in \mbox{Hom}(s^2{\bf g}, {\bf K}) \quad\mbox{\tt\small for }\quad a\in \{1,\ldots,{\rm dim}{\bf g}\}
   }
In this language:
@(align
  r.l.n
  `("" @,f{\alpha \;=\; F^{a_1}\cdots F^{a_n} \; s^{-1}(e_{a_1}\otimes\cdots\otimes e_{a_n})}
       "")
  `(""
    @,f{T^{(a_1\ldots a_n)}d_{\Omega} s^{-1}(e_{a_1}\otimes\cdots\otimes e_{a_n})\;=\;
          (-)^{a_1}T^{(a_1\ldots a_n)} s^{-1}e_{a_1}\otimes s^{-1}(e_{a_2}\otimes\cdots\otimes e_{a_n})\;+}
       "")
  `(""
    @,f{+\;(-)^{a_1+a_2}T^{(a_1\ldots a_n)} s^{-1}(e_{a_1}\otimes e_{a_2})\otimes s^{-1}(e_{a_3}\otimes\cdots\otimes e_{a_n})+\ldots}
    "")
  )
for @f{T^{(a_1\ldots a_n)}} any tensor symmetric in @f{a_1\ldots a_n}.
To agree with @cite{Alekseev:2010gr}, we will denote:
@(align
  r.l.n
  `(""
    @,f{i_{a_1\ldots a_n} = s^{-1}(e_{a_1}\otimes\cdots\otimes e_{a_n})}
    "")
  `(""
    @,f{i(F) = \alpha = F^{a_1}\cdots F^{a_n} i_{a_1\ldots a_n}}
    @,label{iF})
  `(""
    @,f{l\langle F\rangle = F^a e_a \mbox{ \tt\small where } e_a\in{\bf g}\subset {\bf g} \stackrel{\rightarrow}{\oplus} \mbox{FreeLie}\left(s^{-1}  \overline{A^{\ashriek}}\right)}
    @,label{lF})
  )
Here the notation @f{l\langle F\rangle} agrees with Eq. (@ref{EmbeddingL}).

@subpage[2 "Ghost number" #:tag "sec:GhostNumber"]

In our notations, if @f{X} has ghost number @f{n} then @f{sX} has ghost number @f{n-1}.
In other words, @f{s} @bold{lowers} ghost number. In particular, the cone of the Lie superalgebra
@f{\bf g} is:
@e{
   C{\bf g} = {\bf g} \stackrel{\rightarrow}{\oplus} s{\bf g}
   }
The generator @f{i_{a_1\ldots a_n}} has ghost number @f{-2n+1}.
For example, in
@hyperlink["https://andreimikhailov.com/math/bv/bosonic-string/SolutionOfMasterEqn.html"]{bosonic string theory},
@f{i_a} corresponds to @f{\{c^{\star},\_\} = {\partial\over\partial c}}
where @f{c^{\star}}
is the BV antifield for ghost and @f{\{\_,\_\}} the odd Poisson bracket. As a mnemonic rule,
@f{i_{a_1\ldots a_n}} has the same ghost number as @f{\{(c^{\star})^n,\_\}}. Elements of
@f{{\bf g}} (the first summand in @f{{\bf g} \stackrel{\rightarrow}{\oplus} \mbox{FreeLie}\left(s^{-1}  \overline{A^{\ashriek}}\right)}) all have ghost number zero.


@page[@elem{@f{D'{\bf g}}} #:tag "ExtensionOfDg" #:showtitle #t]

We need to also consider an extension of @f{D{\bf g}}, which we will call @f{D'{\bf g}}, which is obtained
by replacing @f{\mbox{FreeLie}\left(s^{-1}  \overline{A^{\ashriek}}\right)}
with @f{\mbox{FreeLie}(s^{-1}  A^{\ashriek})}:
@e{
   D'{\bf g} = {\bf g}\oplus \mbox{FreeLie}(s^{-1}A^{\ashriek})
   }
In the language of @seclink{sec:FunctionsOfCurvature}, we allow @f{i(0)\neq 0}, but require:
@(align
  r.l.n
  `(""
    @,f{d_{D'\bf g} i(0) + {1\over 2} [i(0),i(0)] = 0}
    "")
  `(""
    @,f{[x, i(0)]=0 \mbox{ \tt\small for all } x\in {\bf g}}
    "")
  )


@page["Ansatz for equivariant form" #:tag "AnsatzForEquivariantForm" #:showtitle #t]

Suppose that the Lie superalgebra @f{\bf g} is realized as vector fields on some supermanifold @f{M}.
This means that pseudo-differential forms on @f{M} are a @f{\bf g}-differential module
(= representation of @f{(C{\bf g}, d_{C\bf g})}).
Consider the equation:
@(align
  r.l.n
  `("" @,f{(d + \iota\langle F\rangle) \omega^{\tt C} = 0} @,label{CartanEq})
  `("" @,f{\omega^{\tt C}\in \mbox{Fun}(s^2{\bf g}\times \Pi TM)} "")
  )
We can write such an equations in any @f{\bf g}-differential module @f{W}, not necessarily
PDFs on @f{M}.

Now suppose that @f{W} is a @f{D'\bf g}-differential module. Since @f{\bf g} is embedded into @f{D'{\bf g}},
we can still write the Cartan Eq. (@ref{CartanEq}):
@e{
   (d + \iota\langle l\langle F\rangle \rangle)\omega^{\tt C} = 0
   }
where we use the notations of Eqs. (@ref{EmbeddingL}), (@ref{lF}).



Then, given any @f{d}-closed
form @f{\omega}, consider the following anstaz for a solution of Eq. (@ref{CartanEq}):
@e{
   \omega^{\tt C} = \exp(\iota\langle i(F)\rangle)\omega
   }
where @f{i(F)} is from Eq. (@ref{iF}).
We will show that under certain conditions this substitution solves Eq. (@ref{CartanEq}).


@page[@elem{@f{CD\bf g}} #:tag "SpecialCocycles" #:showtitle #t]

@subpage[1 @elem{@f{D'\bf g}-differential modules} #:tag "DGDifferentialModules"]

Suppose that @f{W} is a @f{D'\bf g}-differential module. This means that @f{W}
is a representation of the Lie superalgebra @f{CD'\bf g},  with the
differential @f{d_W} which agrees with the differential @f{d_{CD'\bf g}} of @f{CD'{\bf g}}.
(The differential of @f{D'\bf g}, which we denote @f{d_{D'\bf g}}, does @bold{not} participate
     in these definitions, but will play its role.)

For every   @f{x\in D'\bf g} we denote @f{{\cal L}\langle x\rangle} and @f{\iota\langle x\rangle}
the corresponding elements of @f{CD'\bf g}, and @f{{\cal L}_W\langle x\rangle} and @f{\iota_W\langle x\rangle}
their action in @f{W}. With the notations of  Eqs. (@ref{EmbeddingL}) and (@ref{lF}),
Eq. (@ref{DMwithExpIota}) implies, for all @f{\omega\in W}:
@(align
  r.l.n
  `(""
    @,f{(d_W + \iota_W\langle l \langle F\rangle\rangle) \exp\left(-\iota_W\langle i(F)\rangle\right) \omega \;=\;}
    "")
  `(@,f{\;=\;}
       @,f{\exp\left(
                     -\iota_W\langle i(F)\rangle
                     \right)
                    \left(d_W + \iota_W\langle d_{D'\bf g}i(F)\rangle + {\cal L}_W\langle i(F)\rangle\right)\omega
                    }
       @,label{EIota})
  )
Let us consider Eq. (@ref{CartanWithEIota}) in the special case when @f{\omega} satisfies:
@(align
  r.l.n
  `("" @,f{d_W\;\omega = 0} @,label{OmegaIsClosed})
  `("" @,f{\left((-)^{\bar{x}+1}\iota_W\langle d_{D'\bf g}x\rangle + {\cal L}_W\langle x\rangle\right)\omega = 0}
       @,label{SpecialRelation})
  )
for all @f{x\in D'\bf g}. Then:
@e{
   (d_W + \iota_W\langle l\langle F\rangle\rangle) \exp\left(-\iota_W\langle i(F)\rangle\right) \omega = 0
   }
Eq. (@ref{SpecialRelation}) is a special requirement on @f{W} and @f{\omega}.
It is by no means automatic. Intuitively, it may be understood as an interplay between @f{d_W} and @f{d_{D'\bf g}}
(and @f{\omega}):
@(align
  r.l.n
  `("" @,f{d_W\iota_W\langle x\rangle \omega = \iota_W\langle d_{D'\bf g}x\rangle\omega} @,label{InterplayD})
  )
We do not requite that @f{d_{D'\bf g}} act in @f{W}.
Instead, we want Eqs. (@ref{OmegaIsClosed}) and (@ref{SpecialRelation})
(or, equivalently, Eqs. (@ref{OmegaIsClosed}) and (@ref{InterplayD})).

We will now consider two examples of @f{D'\bf g}-differential modules.

@subpage[1 "Pseudo-differential forms (PDF)" #:tag "sec:SpecialPDFs"]

Suppose that a supermanifold @f{M} comes with an infinitesimal action of @f{D'{\bf g}},
@italic{i.e.} a homomorphism:
@e[#:label "FromDgToVect"]{
   r\;:\;{D'\bf g} \rightarrow \mbox{Vect}(M)
   }
This is only a homomorphism of Lie superalgebras;
we forget, for now, about the differential @f{d_{D'\bf g}}.

We denote @f{d_M} the deRham differential on @f{M}, and @f{F = F^a e_a}.
Then Eq. (@ref{DMwithExpIota}) implies 
@e[#:label "CartanWithEIota"]{
   (d_M + \iota\circ F) \exp(-\iota\circ\alpha) \omega =
   \exp(-\iota\circ\alpha) (d_M + \iota\circ (d_{D'\bf g}\alpha) + {\cal L}\circ\alpha)\omega
   }
Let us consider Eq. (@ref{CartanWithEIota}) in the special case when @f{\omega} is closed:
@e{
   d\omega = 0
   }
Consider a linear subspace @f{{\cal X}_{\omega}\subset \mbox{Vect}(M)} consisting of all vectors @f{v} such that exits
some other vector @f{d_{\omega}v\in {\cal X}_{\omega}} satisfying: 
@e[#:label "DefDOmega"]{
   - d\iota\langle v\rangle \omega = \iota\langle d_{\{\omega\}} v\rangle\omega
   }
Suppose that @f{\omega} is ``non-degenerate'' in the sense that the map from
@f{\mbox{Vect}M} to PDFs on @f{M} given by @f{v\mapsto \iota_v\omega} is injective.
Then Eq. (@ref{DefDOmega}) defines an odd nilpotent operator:
@e{
   d_{\{\omega\}} \;:\; {\cal X}_{\omega} \rightarrow {\cal X}_{\omega}
   }
Moreover, @f{{\cal X}_{\omega}} is closed under the operation of commutator of vector fields.
Indeed:
@(align
  r.l.n
  `(""
    @,f{(-)^{v+w+1}d\iota_{[v,w]}\omega = {\cal L}\langle [v,w]\rangle \omega = (-)^{v+w+1} d\iota\langle [v,w]\rangle\omega \;=\;}
    "")
  `(@,f{\;=\;}
    @,f{(-)^w {\cal L}\langle v\rangle\iota\langle d_{\{\omega\}}w\rangle \omega
           + (-)^{vw+v+1} {\cal L}\langle w\rangle \iota\langle d_{\{\omega\}}v\rangle \omega \;=
           }
    "")
  `(@,f{\;=\;}
       @,f{\iota\langle (-)^w[v,d_{\{\omega\}}w] + (-)^{vw + v + 1} [w,d_{\{\omega\}}v]\rangle\omega}
       "")
  )
Therefore @f{({\cal X}_{\omega},d_{\{\omega\}})} is a differential Lie superalgebra.

Suppose that:
@(align
  r.l.n
  `("" @,f{\mbox{im} \left(r\,:\,{D'\bf g}\rightarrow \mbox{Vect}(M)\right) \;\subset\; {\cal X}_{\omega}} "")
  `("" @,f{d_{\{\omega\}}r(x) = r(d_{D'\bf g}x)} "")
  )
Then Eq. (@ref{CartanWithEIota}) implies that:
@(align
  r.l.n
  `(""
    @,f{(d_M + \iota\circ F) \exp(\iota\circ\alpha) \omega = 0}
    "")
  )
In other words, @f{\omega^{\tt C}} defined by the equation:
@e{
   \omega^{\tt C} =  \exp(\iota\circ\alpha) \omega
   }
is a cocycle in the Cartan's model of equivariant cohomology.

Notice that apriori there is no action of @f{d_{D'\bf g}} on @f{M}, and we have never used it.

@subpage[1 "Special cocycles" #:tag "sec:SpecialCocycles"]

Similarly, suppose that @f{D'\bf g} is mapped into some Lie superalgebra @f{\bf a}:
@e{
   r\;:\;{D'\bf g} \rightarrow {\bf a}
   }
and @f{W} is a representation of @f{\bf a}. 
Consider the Chevalley-Eilenberg cochain complex @f{C({\bf a},W)}  of @f{\bf a} with coefficients in @f{W}.
The cone @f{C\bf a} acts on  @f{C({\bf a},W)};
for each @f{x\in \bf a} we denote @f{{\cal L}\langle x\rangle} and @f{\iota\langle x\rangle}
the action of the corresponding elements of @f{C\bf a}.
Eq. (@ref{CartanWithEIota}) still holds, now @f{\omega}  is a cochain:
@e{
   \omega\in C({\bf a},W)
   }
We are allowing arbitrary dependence of cochains on the ghosts of @f{\bf a}, not only polynomials.
We will say that a cocycle @f{\omega} is @bold{special} if exists @f{d_{\{\omega\}}} satisfying Eq. (@ref{DefDOmega})
for all @f{v\in\mbox{im}(r)}.

Moreover, we require:
@e[#:label "RIntertwinesDifferentials"]{
   d_{\{\omega\}} \circ r = r \circ d_{D'\bf g}
   }
   

@subpage[1 @elem{A procedure for constructing @f{r}} #:tag "sec:ProcedureForR"]

We will now describe a procedure for constructing an embedding:
@e{
   r\;:\;{D\bf g} \rightarrow {\bf a}
   }
This is not really an ``algorithm'' because, as we will see,  it may fail at any step.

Suppose that we can choose, for each @f{a\in \{1,\ldots,\mbox{dim} {\bf g}\}}, some
@f{\phi_a\in \bf a} so that exist @f{\phi_{ab}\in{\bf a}} such that:
@(align
  r.l.n
  `(""
    @,f{[ \phi_a , \phi_b ] = d \phi_{ab}}
    "")
  `(""
    @,f{[ \phi_a , d \phi_b ] = f_{ab}{}^c \phi_c}
    "")
  )
where @f{d=d_{\omega}} and @f{f_{ab}{}^c} the structure constants of @f{\bf g}. Then verify the existence
of @f{\phi_{abc}} such that:
@(align
  r.l.n
  `(""
    @,f{[\phi_a,\phi_{bc}] + [\phi_{ab},\phi_c] = d\phi_{abc}}
    "")
  `(""
    @,f{[\phi_{ab},d\phi_c] = f_{ac}{}^d \phi_{db} + f_{bc}{}^d\phi_{ad}}
    "")
  )
The mutual consistency of these two equations follows from Eq. (@ref{DsAnticommute}).
Then continue this procedure order by order in the number of indices:
@(align
  r.l.n
  `(""
    @,f{[\phi_{a_1},\phi_{a_2\ldots a_n}] + \ldots + [\phi_{a_1\ldots a_{n-1}},\phi_{a_n}] =
                                          d\phi_{a_1\ldots a_n}}
    "")
  `(""
    @,f{[\phi_{a_1\ldots a_{n-1}},d\phi_b] = f_{a_1 b}{}^c \phi_{c a_2\ldots a_{n-1}} + \ldots}
    "")
  )
If we are able to satisfy these equalities, order by order in the number of indices, then we can put,
in notations of Eqs. (@ref{iF}) and (@ref{lF}):
@(align
  r.l.n
  `(""
    @,f{r\langle l_a\rangle = d\phi_a}
    "")
  `(""
    @,f{r\langle i_{a_1\ldots a_n}\rangle = \phi_{a_1\ldots a_n}}
    "")
  )



@page[@elem{Chevalley-Eilenberg complex of a differential module} #:tag "sec:ExpOfIota" #:showtitle #t]


         In this Section, there is no @f{D{\bf g}} nor @f{D'\bf g}. We forget about them for now.
As a preparation for BV formalism, we will now discuss yet another formula of Kalkman type.

Consider a Lie superalgebra @f{\bf a} and its cone @f{C{\bf a}}, which is generated by
@f{{\cal L}\langle x\rangle} and @f{\iota\langle x\rangle}, where @f{x\in \bf a}.
We consider the quadratic-linear dual coalgebra @f{U{\bf a}^{\ashriek}}.
The dual space @f{\left(U{\bf a}^{\ashriek}\right)^* = \mbox{Hom}\left(U{\bf a}^{\ashriek},{\bf K}\right)}
is the algebra of functions of the ``ghost variables'' @f{c^A}. The universal twisting morphism is:
@e{
   \alpha = c^A e_A\;:\; U{\bf a}^{\ashriek} \rightarrow {\bf a} \subset U{\bf a}
   }
We will study the properties of the following operator:
@(align
  r.l.n
  `(""
    @,f{\exp\left(\iota\circ\alpha\right)\;\in\; \mbox{Hom}\left(U{\bf a}^{\ashriek}, UC{\bf a}\right)}
    "")
  `(""
    @,f{\iota\circ\alpha = c^A\iota\langle e_A\rangle = \iota\langle c\rangle}
    "")
  )
Since @f{\bold a} is quadratic-linear, @f{U{\bf a}^{\ashriek}} comes with the differential
@f{d_{U{\bf a}^{\ashriek}}}. The dual differential on @f{\left(U{\bf a}^{\ashriek}\right)^*}
is the @bold{Chevalley-Eilenberg differential} @f{d_{\rm CE}^{(0)}} (the BRST operator):
@e{
   d_{\rm CE}^{(0)} = \left(d_{U{\bf a}^{\ashriek}}\right)^* = f^A_{BC} c^Bc^C{\partial\over\partial c^A}
   }
Here @f{d_{U{\bf a}^{\ashriek}}} is the ``internal'' differential of @f{U{\bf a}^{\ashriek}};
it comes from @f{U{\bf a}} being inhomogenous
(@italic{i.e.} quadratic-linear and not purely quadratic algebra).



The Chevalley-Eilenberg complex @f{C^{\bullet}({\bf a}, W)} with coefficients in @f{W} can be defined
for any representation @f{\bf a}-module @f{W}. Consider the special case when @f{W} is a @f{\bf a}-differential
module @f{W}, @italic{i.e.}
a representation of @f{(C{\bf a},d_{C{\bf a}})}. We will denote
@f{{\cal L}_W\langle x\rangle}, @f{\iota_W\langle x\rangle} and @f{d^W_{C\bf a}} the elements of
@f{\mbox{End}(W)} representing elements @f{{\cal L}\langle x\rangle},  @f{\iota\langle x\rangle}
of @f{C\bf a} and @f{d_{C\bf a}}.
(Then @f{W} is also a representation
of @f{\bf a}, where @f{x\in\bf a} is represented by @f{{\cal L}_W\langle x\rangle}.)

Consider the Lie algebra cochain complex (= Chevalley-Eilenberg complex)
of @f{\bf a} (@bold{not}  @f{C{\bf a}}) with coefficients in
@f{W}. The differential is defined as follows:
@(align
  r.l.n
  `(@,f{d_{\rm CE}\;\in\;}
       @,f{\mbox{Hom}\left(U{\bf a}^{\ashriek},W\right)}
       "")
  `(@,f{d_{\rm CE} \;=\;}
       @,f{\left(d_{U{\bf a}^{\ashriek}}\right)^* + {\cal L}_W\circ \alpha
                \;=\;d_{\rm CE}^{(0)} + {\cal L}_W\langle c\rangle}
       "")
  `(@,f{d^{(0)}_{\rm CE} \;=\;}
       @,f{f^A_{BC} c^Bc^C{\partial\over\partial c^A}}
       "")
  )
All this can be defined for any  @f{\bf a}-module @f{W}. But when @f{W} is also a @f{\bf a}-@bold{differential}
module (@italic{i.e.} a represenatation of @f{({C\bf a},d_{C\bf a})}), then @f{d_{\rm CE}} and @f{d_{\rm CE}^{(0)}} are related:
@e[
   #:label "ExpIota"
   ]{
     (d^W_{C\bf a} + d_{\rm CE})\exp\,\iota_W\circ\alpha
     = \left(\exp\,\iota_W\circ\alpha \right)(d^W_{C\bf a} + d_{\rm CE}^{(0)})
   }
(where @f{\iota_W\circ\alpha = \iota_W\langle c\rangle}).

Moreover, since @f{W} and @f{U{\bf a}^{\ashriek}} are both @f{C\bf a}-modules,
we can consider @f{\mbox{Hom}(U{\bf a}^{\ashriek}, W)} a @f{C\bf a}-module, as a @f{\mbox{Hom}} of
two @f{C\bf a}-modules:
@(align
  r.l.n
  `(@,f{\iota^{(0)}_{{\rm Hom}(U{\bf a}^{\ashriek}, W)}\langle x\rangle\;=\;}
       @,f{\iota_W\langle x\rangle + x^A{\partial\over\partial c^A}}
       "")
  `(@,f{{\cal L}^{(0)}_{{\rm Hom}(U{\bf a}^{\ashriek}, W)}\langle x\rangle\;=\;}
       @,f{{\cal L}_W\langle x\rangle + x^Ac^Bf_{AB}^{C}{\partial\over\partial c^C}}
       "")
  )

@bold{Proposition @(th-num "BRSTofDifferentialModule")}

@(align
  r.l.n
  `(""
    @,f{\iota_{{\rm Hom}(U{\bf a}^{\ashriek}, W)}\langle x\rangle 
              \left(\exp\,\iota_W\circ\alpha\right) \;=\;
              \left(\exp\,\iota_W\circ\alpha\right)
              \iota^{(0)}_{{\rm Hom}(U{\bf a}^{\ashriek}, W)}\langle x\rangle }
    "")
  `(""
    @,f{{\cal L}_{{\rm Hom}(U{\bf a}^{\ashriek}, W)}\langle x\rangle 
                \left(\exp\,\iota_W\circ\alpha\right) \;=\;
                \left(\exp\,\iota_W\circ\alpha\right)
                {\cal L}^{(0)}_{{\rm Hom}(U{\bf a}^{\ashriek}, W)}\langle x\rangle }
    "")
  `(@,elem[#:style 'no-break]{where @hspace[2]}
          @,f{\iota_{{\rm Hom}(U{\bf a}^{\ashriek}, W)}\langle x\rangle =
                    x^A{\partial\over\partial c^A}}
          "")
  `(""
    @,f{{\cal L}_{{\rm Hom}(U{\bf a}^{\ashriek}, W)}\langle x\rangle =
                {\cal L}^{(0)}_{{\rm Hom}(U{\bf a}^{\ashriek}, W)}\langle x\rangle}
    "")
  )
In other words, 

@noindent
both
@f{({\cal L}^{(0)}_{{\rm Hom}(U{\bf a}^{\ashriek}, W)},
            \iota^{(0)}_{{\rm Hom}(U{\bf a}^{\ashriek}, W)},
            d^W_{C\bf a} + d_{\rm CE}^{(0)})}

@noindent
and
@f{({\cal L}_{{\rm Hom}(U{\bf a}^{\ashriek}, W)},
            \iota_{{\rm Hom}(U{\bf a}^{\ashriek}, W)},
            d^W_{C\bf a} + d_{\rm CE})}
define on @f{{\rm Hom}(U{\bf a}^{\ashriek}, W)} the structure of a differential @f{\bf a}-module,
and @f{\exp\,\iota_W\circ\alpha} intertwines them.

@page[@elem{Integration measures from representations of @f{C\bf g} and @f{D\bf g}} #:tag "PDFsFromRepresentations" #:showtitle #t]

@subpage[1 @elem{PDFs from representations of @f{C\bf g}} #:tag "sec:PDFsFromCg"]

If @f{\bf g} acts on a manifold, then @f{C\bf g} acts in PDFs. Also, @f{C\bf g}
acts in cochains of Chevalley-Eilenberg complexes of @f{\bf g}.

@noindent
@bold{Question:} Given some representation @f{W} of @f{(C{\bf g}, d_{C\bf g})}, can we map it to PDFs, or to cochains?

@subpage[2 @elem{Mapping to cochains} #:tag "sec:ToCochains"]

@bold{Proposition @th-num{DtoQ}.}
Let @f{\cal W} be a representation of @f{\bf g}, and
@f{\intoper : W\rightarrow \cal W} an intertwiner of @f{\bf g}-modules:
@(align
  r.l.n
  `(@,f{\intoper\;:\;}
       @,f{W\rightarrow {\cal W}}
       "")
  `(@,elem[#:style 'no-break]{satisfying: @hspace[2]}
          @,f{\intoper\circ d^W_{C\bf g} =0}
          @,label{IdCgZero})
  )
(We think of @f{\intoper} as some kind of an ``integration operation''.)
Consider the subspace
@e{
   \mbox{ker}\, d^{(0)}_{\rm CE} \subset \mbox{Hom}\left(U{\bf g}^{\ashriek},W\right)
   }
Then operation @f{\intoper\circ e^{\iota_W\circ\alpha}} intertwines this subspace
with the  Chevalley-Eilenberg complex @f{C^{\bullet}({\bf g}, {\cal W})}:
@e{
   \intoper\circ e^{\iota_W\circ\alpha}\;:\;
   (\mbox{ker} \,d^{(0)}_{\rm CE}\,,\, d^W_{C\bf g})
   \rightarrow
   (\mbox{Hom}\left(U{\bf g}^{\ashriek},{\cal W}\right)\,,\,d_{\rm CE})
   }
@bold{Proof} follows from Eq. (@ref{ExpIota}).


Therefore every @f{w\in W} defines an inhomogeneous Chevalley-Eilenberg cochain of @f{\bf g} with coefficients in @f{\cal W}:
@(align
  r.l.n
  `(""
    @,f{\psi\langle w\rangle  = \intoper e^{\iota_W\circ \alpha} w}
    "")
  )
The map    @f{\intoper\circ e^{\iota_W\circ\alpha}} intertwines the action of @f{C\bf g} on
@f{\mbox{ker} \,d^{(0)}_{\rm CE}} with the standard action of @f{C\bf g} in cochains with
coefficients in @f{\cal W} --- the
@f{({\cal L}^{(0)}_{{\rm Hom}(U{\bf b}^{\ashriek}, {\cal W})},
            \iota^{(0)}_{{\rm Hom}(U{\bf b}^{\ashriek}, {\cal W})})} of
@bold{Proposition} @th-ref{BRSTofDifferentialModule}.
(This action does not use @f{\iota^{\cal W}\langle x\rangle},
      in fact there is no such thing as @f{\iota^{\cal W}\langle x\rangle}.
      Our @f{\cal W}, unlike @f{W}, is just a @f{\bf g}-module, not a differential @f{\bf g}-module.)
                                                          

@subpage[2 "Mapping to PDFs" #:tag "sec:ToPDFs"]

Suppose that @f{\cal W} happens to be a space of functions  on some manifold
@f{M} with an action of  @f{G} (the Lie group corresponding to @f{\bf g}).
In this case, every @f{w\in W} and a point @f{m\in M} defines a closed PDF on @f{G}, in the following way:
@e[#:label "DefOmegaWI"]{
   \Omega\langle w\rangle(g,dg)=\left(\intoper e^{-\iota_W\langle dgg^{-1}\rangle} w\right)(g.m)
   }
We will be mostly interested in the cases when this PDF descends on the @f{G}-orbit of @f{m}. 

For example, consider the case when @f{W} is the space of PDFs on @f{M} (the same @f{M})
and @f{\intoper} is the restriction of a PDF on the zero section @f{M\subset \Pi TM}.
(Remember that PDFs are functions on @f{\Pi TM}. In this example, the operation @f{\intoper} associates
          to every form its 0-form component.) In this case, given a PDF on @f{M},
@italic{e.g.} @f{f_{\mu}(x)dx^{\mu}}, our procedure, for each @f{x\in M}, associates to it a PDF on @f{G},
which is just @f{f_{\mu}(g.x)d(g.x)^{\mu}}. 
If @f{G} acts freely, @f{\Omega\langle w\rangle} will descend to a form on the orbit of @f{x}. This is just the
restriction to the orbit of the original form we started with.

As another example, consider @f{\bf g} the Lie algebra of vector fields on some manifold @f{N},
and @f{W} the space of PDFs on @f{N}. Let @f{M} be the space of orientable @f{p}-dimensional
submanifolds of @f{N}, and @f{\intoper} the operation of integration over such a submanifold.
Our construction maps closed forms on @f{N} to closed forms on @f{M}. 


@subpage[1 @elem{PDFs from representations of @f{D\bf g}} #:tag "PDFsFromDg"]

An analogue of Eq. (@ref{ExpIota}) holds for @f{D\bf g}. It follows as a particular case from
the results of @cite{Alekseev:2010gr}:
@e{
   \left(d_{D\bf g} + d_{\rm CE}\right) \Phi = \Phi \left(d_{D\bf g} + d^{(0)}_{\rm CE}\right)
   }
where @f{\Phi} is:
@(align
  r.l.n
  `(""
    @,f{\Phi = P\exp\int_0^1  {\cal A}_{\tau}d\tau}
    "")
  `(""
    @,f{A_{\tau}d\tau = \left.{d\over du}\right|_{u=0}i(u \, d\tau \, c   + (\tau - \tau^2)c^2)}
    "")
  )
Therefore, when @f{W} is a representation of @f{D\bf g}, we have an analogue of Eq. (@ref{DefOmegaWI}),
where @f{\intoper} should now satisfy @f{\intoper\circ d_{D\bf g}^W = 0}:
@(align
  r.l.n
  `(""
    @,f{\Omega\langle w\rangle = \left(\intoper\; \Phi|_{c \mapsto dg g^{-1}}\,w\right)(g.m)}
    @,label{OmegaFromDg})
  `(""
    @,f{d\Omega \langle w\rangle = \Omega\langle d^W_{D\bf g}w\rangle}
    "")
  )

  

@page["BV" #:tag "BV" #:showtitle #t]

We will now apply the technique developed in the previous sections to the BV formalism.

Let @f{\bf a} be the Lie algebra of functions on the BV phase space with flipped statistics.
Its elements are @f{s^{-1}f} where @f{f} is a function on the BV phase space and @f{s} the suspension:
@e{
   s^{-1}f\in \bf a
   }
The Lie bracket is given by the odd Poisson bracket.

@subpage[1 @elem{Half-densities as a representation of @f{C{\bf a}}} #:tag "sec:BVRepOfCone"]

The space of half-densities on the BV phase space is a representation of @f{C{\bf a}} :

@(align
  r.l.n
  `(@,f{d \rho_{1/2} =} @,f{\;  - \Delta_{\rm can} \rho_{1/2}} "")
  `(@,f{\iota\langle s^{-1}f\rangle \rho_{1/2} =} @,f{\;  f\rho_{1/2}} "")
  `(@,f{{\cal L}\langle s^{-1}f\rangle \rho_{1/2} =} @,f{\; (-)^{|f|}\Delta_{\rm can} (f\rho_{1/2}) - f\Delta_{\rm can}  \rho_{1/2}} "")
  )



We are now in the context of  〚@seclink["sec:PDFsFromCg"]{@secref{sec:PDFsFromCg}}〛.
Now @f{\bf g} is @f{\bf a}, @f{W} is the space of half-densities,
@f{d^W_{C\bf g}} is @f{-\Delta_{\rm can}}
and @f{\cal W} is @f{\mbox{Fun}({\rm LAG})} --- the space of functions on Lagrangian submanifolds.


@subpage[1 @elem{Correlation functions as a Lie superalgebra cocycle} #:tag "sec:CorrelationFunctionsAreCocycle"]

Correlation function defines a linear map:
@(align
  r.l.n
  `(""
    @,f{U{\bf a}^{\ashriek} \longrightarrow \mbox{Fun}({\rm LAG})}
    "")
  `(""
    @,f{f_1\bullet\cdots\bullet f_n \mapsto \left[L \mapsto \int_L f_1\cdots f_n \rho_{1/2}\right]}
    @,label{BVCocycle})
  )
where @f{\bullet} means symmetrized tensor product
(examples of sign rules are in 〚@seclink["sec:DualAlgebraOfFunctions"]{@secref{sec:DualAlgebraOfFunctions}}〛).

@bold{Proposition @(th-num "CorrelatorAsCocycle")}
Eq. (@ref{BVCocycle}) defines an injective map from the space of half-densities to the space of
cochains of @f{\bf a} with values in functionals on Lagrangian submanifolds;
to every half-density @f{\rho_{1/2}} corresponds a cochain given by Eq. (@ref{BVCocycle}).
This map is an intertwiner of the actions of the differential Lie superalgebra @f{C{\bf a}}.
In particular, if @f{\rho_{1/2}} satisfies the Quantum Master Equation:
@e{
   \Delta_{\rm can} \rho_{1/2} = 0
   }
then Eq. (@ref{BVCocycle}) defines a cocycle of @f{\bf a} with coefficients
in the space of functionals on Lagrangian submanifolds.

@bold{Proof} follows from Proposition @th-ref{DtoQ}.


@noindent
The image of this map consists of the cochains satisfying the following @bold{locality property}.
Given @f{f_1,\ldots,f_n}, if for some @f{i} and @f{j}  @f{\mbox{supp}(f_i)\cap \mbox{supp}(f_j) = \mbox{\tt empty set}}
then @f{c(f_1\bullet\ldots\bullet f_n) = 0}.
It is important for us, that this subset is preserved by the canonical transformations,
@italic{i.e.} by the action of @f{\bf a} on its cocycles. 



Cocycles with
coefficients in @f{\mbox{Fun}({\rm LAG})}, defined by Eq. (@ref{BVCocycle}), 
can be interpreted as closed differential forms on @f{\rm LAG}, by the construction
of 〚@seclink["sec:ToPDFs"]{@secref{sec:ToPDFs}}〛. We take:
@(align
  r.l.n
  `(""
    @,f{M=\rm LAG}
    @,label{MisLAG})
  `(""
    @,f{\intoper = \left[L\mapsto \int_{L\in\rm LAG} \_ \right]}
    @,label{IntoperLAG})
  )
    
    



@page["Equivariant BV formalism" #:tag "EquivariantBV" #:showtitle #t]

@subpage[1 "Equivariantly closed cocycle in the Cartan model" #:tag "sec:EquivariantCocycle"]

For all cocycles coming from half-densities, Eq. (@ref{DefDOmega}) is satisfied with:
@(align
  r.l.n
  `(""
    @,f{d_{\{\omega\}} f = \Delta_{\rho_{1/2}} f}
    "")
  `(@,elem[#:style 'no-break]{where @hspace[1]}
          @,f{\Delta_{\rho_{1/2}}f = \rho_{1/2}^{-1}\Delta_{\rm can} \left(f\rho_{1/2}\right)}
          "")
  )
As in  〚@seclink["sec:SpecialCocycles"]{@secref{sec:SpecialCocycles}}〛,
suppose that @f{r} is an embedding of @f{D'\bf g} in @f{\bf a}.
Eq. (@ref{RIntertwinesDifferentials}) becomes (@italic{cp} Eqs. (@ref{iF}) and (@ref{lF})):
@(align
  r.l.n
  `(""
    @,f{\Delta_{\rho_{1/2}} r\langle i(F)\rangle + {1\over 2}[r\langle i(F)\rangle,r\langle i(F)\rangle] =
               r\langle l\langle F\rangle\rangle}
    @,label{DeltaR})
  `(""
    @,f{[r\langle l\langle F_1\rangle\rangle , r\langle i(F_2)\rangle]
        = \left.{d\over dt}\right|_{t=0} r\langle i(e^{t[F_1,\_]}F_2)\rangle}
    @,label{Equivariance})
  `(""
    @,elem[#:style 'no-break]{where @f{i(F)} and @f{l\langle F\rangle} were defined in Eqs. (@ref{iF}) and (@ref{lF})}
    "")
  )
Then, equivariantly closed cocycle in the Cartan model is given by:
@e{
   f_1\bullet\cdots\bullet f_n \mapsto
   \left[L \mapsto \int_L f_1\cdots f_n e^{r\langle i(F)\rangle}\rho_{1/2}\right]
   }
Our notations here differ from our previous papers;
@f{r\langle i(F)\rangle} was called @f{\Phi(F)} in Section 4 of @cite{Mikhailov:2016myt}
and @f{a(F)} in Section 6 of @cite{Mikhailov:2016rkp}. Here is the summary of notations:

@(tbl
  #:orient 'hor
  `(("here"
     @,f{F}
     @,f{i(F)}
     @,f{l\langle F\rangle}
     @,f{r\langle i(F)\rangle}
     @,f{r\langle i_aF^a\rangle}
     @,f{r\langle l\langle F\rangle\rangle}
     )
    (@,elem{@cite{Alekseev:2010gr}}
           @,f{t}
           @,f{i(t)}
           @,f{l(t)}
           ""
           ""
           "")
    (@,elem{Section 4 of @cite{Mikhailov:2016myt}}
           @,f{h}
           ""
           ""
           @,f{\Phi(h)}
           ""
           "")
    (@,elem{Section 6 of @cite{Mikhailov:2016rkp}}
           @,f{\xi}
           ""
           ""
           @,f{a(\xi)}
           @,f{\Phi\langle \xi\rangle}
           @,f{\underline{\xi}})
    )
  )

@subpage[1 "Deformations" #:tag "sec:Deformations"]

If @f{r\langle l\langle F\rangle\rangle} and @f{r\langle i(F)\rangle} solve
Eqs. (@ref{DeltaR}) and (@ref{Equivariance}) with some @f{\rho_{1/2}}, then
@f{r\langle l\langle F\rangle\rangle} and @f{r\langle i(F)\rangle - f} solve
with @f{e^f\rho_{1/2}}. This allows us to assume, without loss of generality, that @f{r\langle i(0)\rangle =0},
@italic{i.e.} to consider representations of @f{D\bf g} rather than @f{D'\bf g}. 
Or, we can fix @f{\rho_{1/2} = \rho_{1/2}^{(0)}} for some fixed @f{\rho_{1/2}^{(0)}}. Let us fix  the half-density,
delegating the deformations @f{\rho_{1/2}} into @f{r\langle i(0)\rangle}.

Consider the deformations of the embedding @f{r\;:\; {D'\bf g} \rightarrow {\bf a}} keeping
@f{r\langle l\langle F\rangle\rangle} fixed.
@comment{
         Notice that @f{r\langle l\langle F\rangle\rangle} describes the action of symmetries on the BV
         phase space. We do not want to deform the action of symmetries.
         }
Eq. (@ref{DeltaR}) implies that a small variation @f{\delta r\langle i(F)\rangle} satisfies:
@(align
  r.l.n
  `(""
    @,f{\left(
              \Delta_{\rho_{1/2}} + 
              [r\langle i(F)\rangle,\_]
              \right)\;\delta r\langle i(F)\rangle \;=\; 0}
    "")
  `(""
    @,f{[r\langle l\langle F_1\rangle\rangle , \delta r\langle i(F_2)\rangle]
        = \left.{d\over dt}\right|_{t=0} \delta r\langle i(e^{t[F_1,\_]}F_2)\rangle}
    "")
  )
Those @f{\delta r} which are in the image of @f{\Delta_{\rho_{1/2}} + [r\langle i(F)\rangle,\_]}
correspond to trivial deformations. This means that 
the cohomologies of the operator @f{d_{D{\bf g}} + [i(F),\_]}, considered in @cite{Alekseev:2010gr},
in our context compute @bold{infinitesimal deformations} of the equivariant half-density.

@page["Integrating unintegrated vertices" #:tag "IntegratedAndUnintegrated" #:showtitle #t]

@bystro-local-toc[]

@subpage[1 @elem{Integration prescription using @f{C\bf g}} #:tag "sec:IntegrateUsingCone"]

Let us fix @f{i(0)=0}, and consider @f{r\,:\,D{\bf g}\rightarrow {\bf a}}.
In our discussion in 〚@seclink["sec:Deformations"]{@secref{sec:Deformations}}〛,
we assumed that deformations preserve the symmetries of @f{\omega}, @italic{i.e.} that @f{f} is
@f{\bf g}-invariant. In string theory, it is useful to consider more general deformations
breaking @f{\bf g} down to a smaller subalgebra @f{{\bf g}_0}. They are called ``unintegrated vertex operators''.
As their name suggests, @f{\bf g}-invariant deformations can be obtained by integration
over the orbits of @f{\bf g}. The procedure of integration
@hyperlink["https://andreimikhailov.com/math/bv/unintegrated-vertex/index.html"]{was described}
in @cite{Mikhailov:2016rkp}.
It is a particular case of 〚@seclink["sec:PDFsFromCg"]{@secref{sec:PDFsFromCg}}〛,
where @f{M} is now @f{\rm LAG} --- the space of Lagrangian submanifolds, and
@f{\intoper} the operation of integration of half-density over a Lagrangian submanifold.



For this construction, we do not need the full @f{r\,:\, D{\bf g} \rightarrow {\bf a}}, but only
its restriction on @f{{\bf g}\subset {\bf a}}:
@(align
  r.l.n
  `(""
    @,f{l\,:\,{\bf g}\rightarrow D{\bf g}}
    "")
  `(""
    @,f{r\circ l\,:\,{\bf g}\rightarrow {\bf a}}
    "")
  )
For @f{v\in {\bf a}}, consider the deformations of @f{\omega} of the following form:
@e[#:label "IotaDeformation"]{
   \delta\omega = \iota\langle v\rangle \omega
   }
In terms of half-densities:
@e{
   \delta \rho_{1/2} = \underline{v}\rho_{1/2}
   }
where @f{\underline{v}} denotes (as in @cite{Mikhailov:2016rkp}) the BV Hamiltonian generating @f{v}.


The cone @f{C\bf g} acts on such deformations @f{\delta\rho_{1/2}};
the action of @f{\hat{\iota}\langle x\rangle}, @f{\hat{\cal L}\langle x\rangle}
and @f{\widehat{d_{C\bf g}}} is:
@(align
  r.l.n
  `(""
    @,f{\hat{\iota}\langle x\rangle \delta\omega = -((\iota\circ r\circ l)x)\delta\omega}
    "")
  `(""
    @,f{\hat{\cal L}\langle x\rangle \delta\omega = -(({\cal L}\circ r\circ l)x)\delta\omega}
    "")
  `(""
    @,f{\widehat{d_{C\bf g}}\delta \omega = d\delta \omega}
    @,label{dCgActsAsDelta})
  )
Therefore the construction of 〚@seclink["sec:PDFsFromCg"]{@secref{sec:PDFsFromCg}}〛, with @f{M=\rm LAG}
and @f{\intoper\langle \delta\omega\rangle = \left[L\mapsto \int_{L\in\rm LAG}f\rho_{1/2}\right]},
gives a closed form on @f{G} for every deformation of the form Eq. (@ref{IotaDeformation}):
@(align
  r.l.n
  `(@,f{\Omega\langle v\rangle}
       @,f{\;\in\;\mbox{Fun}(\Pi TG)}
       "")
  `(@,f{\Omega\langle v\rangle}
       @,f{\;=\; 
           \Big(\intoper\;\exp(\iota\langle r\langle l\langle dg g^{-1}\rangle\rangle\rangle)\;
           \iota\langle v\rangle \omega\Big)(gL)\;=\;}
       "")
  `(""
    @,f{\;=\; \int_{gL}\exp\left(\underline{r\langle l\langle dg g^{-1}\rangle\rangle}\right)
              \underline{v} \rho_{1/2}}
    "")
  )
This is just a particular case of the general construction of
〚@seclink["sec:CorrelationFunctionsAreCocycle"]{@secref{sec:CorrelationFunctionsAreCocycle}}〛,
Eqs. (@ref{MisLAG}), (@ref{IntoperLAG}). We restrict the general construction of @f{\Omega}
from all @f{\rm LAG} to an orbit of @f{G}. In other words, we consider not all odd canonical transformations,
but only a subgroup @f{G}.
But now we can use @f{G}-invariance of @f{\rho_{1/2}} to pull back to a fixed @f{L}:
@e[#:label "NonLocalOmega"]{
   \Omega\langle f\rangle
   = \int_{L}\exp\left(\underline{r\langle l\langle dg g^{-1}\rangle\rangle}\circ g\right)
   (\underline{v}\circ g) \rho_{1/2}
   }
However Eq. (@ref{NonLocalOmega}) is somewhat unsatisfactory. 
Although it @bold{is}, actually, the integrated vertex corresponding to @f{v},
this form of presenting it makes it apparently nonlocal on the string worldsheet.
We would want, instead, to replace, roughly speaking, @f{\iota{\cal L}} with  @f{{\cal L}\iota}:
@e{
   \exp\left(\iota\langle r\langle l\langle dg g^{-1}\rangle\rangle\right)
   \stackrel{?}{\mapsto}
   \exp\left({\cal L}\langle r\langle i(dg g^{-1})\rangle\rangle\right)
   }
We will now explain the construction.


@subpage[1 @elem{Integration using @f{D\bf g}} #:tag "sec:IntegrateUsingDg"]
@subpage[2 @elem{Deformations as a representation of @f{D\bf g}} #:tag "sec:DeformationsAsRepOfDg"]

In deriving Eq. (@ref{NonLocalOmega}) we have not actually used the representation of @f{D\bf g},
but only the representation of @f{{\bf g}\subset D{\bf g}};
we have only used @f{l\langle dg g^{-1}\rangle} and never @f{i(dgg^{-1})}.
Notice, however, that the whole @f{D\bf g} acts on deformations.
(This is, ultimately, due to our requirement of @f{\rho_{1/2}} being ``equivariantizeable'',
      〚@seclink["EquivariantBV"]{@secref{EquivariantBV}}〛.)
Moreover, if we do not care about @f{d_{D\bf g}}, then there are two ways of defining the action of
just @f{D\bf g}. (It is easy to construct representations of free algebras.)
The first way is to use the embedding @f{{D\bf g}\stackrel{\cal L}{\rightarrow} CD{\bf g}}.
But this one does not define the action of @f{d_{D\bf g}}.

There is, however, the second way, which defines the action of @f{D{\bf g}} @bold{with} its differential
@f{d_{D\bf g}}. For @f{\delta\omega =\iota\langle v\rangle \omega} or equivalently @f{\delta \rho_{1/2} = \underline{v}\rho_{1/2}}, we define:
@(align
  r.l.n
  `(""
    @,f{\hat{l}\langle F\rangle \;v \;=\; [ r\langle l\langle F\rangle\rangle\,,\,v]}
    "")
  `(""
    @,f{\hat{i}(F) \;v \;=\; [ r\langle i(F)\rangle\,,\,v]}
    "")
  `(""
    @,f{\widehat{d_{D\bf g}}\delta\omega = d\delta\omega}
    @,label{dDgActsAsDelta})
  )
To summarize, the space of deformations of @f{\omega} can be considered
as a representation of @f{(CD{\bf g},d_{CD{\bf g}})}, or as a representation of @f{(D{\bf g},d_{D\bf g})}. (But not of @f{(CD{\bf g}, d_{CD{\bf g}}, d_{D\bf g})} whatever that would be.)
In both cases, the differential acts as @f{\Delta}. That is to say,
the @f{d_{CD{\bf g}}} of @f{(CD{\bf g},d_{CD{\bf g}})} acts as @f{\Delta},
and the @f{d_{D{\bf g}}} of @f{(D{\bf g},d_{D{\bf g}})} also acts as @f{\Delta}
--- see Eqs. (@ref{dCgActsAsDelta}) and (@ref{dDgActsAsDelta}), respectively.


@subpage[2 @elem{Averaging procedure using @f{D\bf g}} #:tag "sec:AveragingUsingDg"]

Now we can apply the construction of 〚@seclink["PDFsFromDg"]{@secref{PDFsFromDg}}〛.
Eq. (@ref{OmegaFromDg}) gives:
@(align
  r.l.n
  `(""
    @,f{\Omega\langle v\rangle = \int_{gL}
                      \left[\left(P\exp\int_0^1 {\cal A}_{\tau}d\tau\right) v\right]\rho_{1/2}}
    @,label{LocalOmega})
  `(@,elem[#:style 'no-break]{where@hspace[2]}
          @,f{A_{\tau}d\tau = \left.{d\over du}\right|_{u=0}
                \hat{i}(u \, d\tau \, dgg^{-1}   + (\tau - \tau^2)(dgg^{-1})^2)}
          "")
  )
For completeness, we compare the notations in the table:

@(tbl
  #:orient 'hor
  `(
    ("now"
     @,f{dg g^{-1}}
     @,f{0}
     @,f{\iota\langle r\langle l\langle dgg^{-1}\rangle\rangle\rangle}
     @,f{{\cal L}\langle r\langle i_a(dgg^{-1})^a\rangle\rangle}
     )
    (@,elem{@cite{Alekseev:2010gr}}
           @,f{\theta}
           @,f{t}
           "--"
           @,f{{\cal I}(\theta)}
           )
    (@,elem{@hyperlink["https://andreimikhailov.com/math/bv/unintegrated-vertex/Descent_Procedure.html"]{Section 12} of @cite{Mikhailov:2016rkp}}
           @,f{c}
           @,f{0}
           @,f{\Delta \Psi}
           @,f{\{\Psi,\_\}})
    )
  )

@noindent
There is no @f{CD\bf g} in @cite{Alekseev:2010gr}, only @f{D\bf g}.



@subpage[1 "Relation between two integration procedures" #:tag "sec:RelationBetweenIntegrations"]

In the special case when @f{D\bf g} reduces to @f{C\bf g} (@italic{i.e.} @f{i_{a_1\ldots a_n} = 0} for @f{n>1}), it
@hyperlink["https://andreimikhailov.com/math/bv/unintegrated-vertex/Descent_Procedure.html"]{was found}
in @cite{Mikhailov:2016rkp}, to the second order in the expansion
in powers of @f{dgg^{-1}}, that the two PDFs are different by an exact PDF on @f{G}.
It must be true in general. 

@subpage[1 @elem{Is integration form base with respect to @f{G_0}?} #:tag "sec:BaseG0"]

Let @f{G_0\subset G} be the stabilizer of @f{v}. Eq. (@ref{NonLocalOmega}) is not base with respect
to @f{{\bf g}_0 =\mbox{Lie} G}. But it can be made base, provided that one can extend @f{v} to the solution
of the equation:
@(align
  r.l.n
  `(""
    @,f{\Delta v(F_0) + [i(F_0),v(F_0)] = 0}
    "")
  `(""
    @,f{\left.{d\over dt}\right|_{t=0} v(e^{t[\xi,\_]} F_0) = [\xi,v(F_0)]}
    "")
  `(""
    @,f{v(0)=v}
    "")
  )
Then, the equivariant version of Eq. (@ref{NonLocalOmega}) is:
@(align
  r.l.n
  `(@,f{\Omega \;=\;}
       @,f{\int_{L}\exp\left(\underline{r\langle l\langle dg g^{-1}\rangle + i(F_0)\rangle}\circ g\right)
                (\underline{v(F_0)}\circ g) \rho_{1/2}\;=}
       "")
  `(@,f{\;=\;}
       @,f{\int_L \left.{d\over d\varepsilon}\right|_{\varepsilon=0}
                  \exp\left[
                            \underline{r\langle l\langle dg g^{-1}\rangle \rangle}\circ g
                            + \left(
                                    \underline{r\langle i(F_0)\rangle} + \varepsilon \underline{v(F_0)}
                                    \right)\circ g
                            \right]\rho_{1/2}}
       "")
  )
and one can obtain a base form by choosing a connection.

We do not know the equivariant version of Eq. (@ref{LocalOmega}).
In the pure spinor formalism, it is very likely that the form given by Eq. (@ref{LocalOmega}) is already base,
because unintegrated vertex operator does not contain derivatives @cite{Flores:2019dwr}.

Notice that the PDF defined in Eq. (@ref{LocalOmega}) does not, generally, speaking, descend
to the orbit of @f{L}. In computing the average, the integration variable is @f{g},  not  @f{gL}.
However, the integral does not depend on the choice of @f{L} in the orbit.



@page["Bibliography" #:tag "Bibliography" #:showtitle #t]

@(bibliography)




@; ---------------------------------------------------------------------------------------------------
@(bystro-close-connection bystro-conf)
@disconnect[formula-database]

  
